#!/usr/bin/env python3
"""Post a feedback ticket to a Gitea repo, linked to the current commit, with
files attached to the issue.

    feedback_bundle.py [--title T] [--label L ...] [--repo REMOTE_URL] [--token T]
                       [--dry-run] <description> [@file ...]

Flow (Gitea attaches files to an existing issue, there is no standalone upload
endpoint): create the issue, then POST each file to
/repos/{owner}/{repo}/issues/{number}/assets (multipart field "attachment").
The ticket body links to `git HEAD` and lists the attached files.

If the assets endpoint returns 403/404 the instance has attachments disabled
(admin `[attachment] ENABLED = true` in app.ini — not a web-UI setting); the
script reports this instead of posting a ticket with no attachments.
"""
from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys

try:
    import requests
except ImportError:  # pragma: no cover
    sys.exit("requests is required: pip install requests")


def run(*args: str) -> str:
    return subprocess.run(args, capture_output=True, text=True, check=True).stdout.strip()


def parse_remote(remote: str | None) -> tuple[str, str, str]:
    """(host, owner, repo) from a git remote URL (scp, ssh, or https forms)."""
    url = remote or run("git", "remote", "get-url", "origin")
    u = re.sub(r"^[a-z]+://", "", url.strip(), flags=re.I)  # strip scheme
    u = u.split("@", 1)[-1]                                  # strip user@
    u = u.replace(".git", "").rstrip("/")
    host, rest = (u.split(":", 1) if ":" in u else u.split("/", 1))
    owner, repo = rest.split("/", 1)
    return host, owner, repo


def load_token(host: str, token: str | None) -> str:
    if token:
        return token
    cfg = os.path.expanduser("~/.config/tea/config.yml")
    if not os.path.exists(cfg):
        sys.exit("no --token and no tea config found; cannot authenticate")
    import yaml

    data = yaml.safe_load(open(cfg).read())
    for login in data.get("logins", []):
        if login.get("url").rstrip("/").endswith(host) and login.get("token"):
            return login["token"]
    sys.exit(f"no stored token for host {host}; pass --token")


def resolve_labels(host, token, owner, repo, names):
    """Gitea's issue API wants label IDs, not names. Map names to IDs; warn on
    unknown labels and drop them."""
    if not names:
        return []
    url = f"https://{host}/api/v1/repos/{owner}/{repo}/labels"
    r = requests.get(url, headers={"Authorization": f"token {token}"})
    if r.status_code >= 400:
        sys.exit(f"could not list labels ({r.status_code}): {r.text}")
    by_name = {l["name"]: l["id"] for l in r.json()}
    ids = []
    for n in names:
        if n in by_name:
            ids.append(by_name[n])
        else:
            print(f"warning: unknown label '{n}', skipping", file=sys.stderr)
    return ids


def create_issue(host, token, owner, repo, title, body, label_ids):
    url = f"https://{host}/api/v1/repos/{owner}/{repo}/issues"
    r = requests.post(url, json={"title": title, "body": body, "labels": label_ids},
                      headers={"Authorization": f"token {token}"})
    if r.status_code >= 400:
        sys.exit(f"issue create failed ({r.status_code}): {r.text}")
    return r.json()


def attach(host, token, owner, repo, issue_number, path):
    """Attach one file to an issue. Returns the browser_download_url, or None
    on 403/404 (attachments disabled on this instance)."""
    url = f"https://{host}/api/v1/repos/{owner}/{repo}/issues/{issue_number}/assets"
    with open(path, "rb") as f:
        r = requests.post(url, files={"attachment": f},
                          params={"name": os.path.basename(path)},
                          headers={"Authorization": f"token {token}"})
    if r.status_code in (403, 404):
        return None
    r.raise_for_status()
    return r.json().get("browser_download_url")


def main() -> int:
    ap = argparse.ArgumentParser(description="Post a commit-linked feedback ticket with attachments.")
    ap.add_argument("description", help="ticket description (text before any @file)")
    ap.add_argument("files", nargs="*", help="files to attach (@name or name)")
    ap.add_argument("--title", help="ticket title (default: first line of description)")
    ap.add_argument("--label", action="append", default=[], help="label to add (repeatable)")
    ap.add_argument("--repo", help="Git remote URL (default: git remote origin)")
    ap.add_argument("--token", help="Gitea token (default: tea config for the host)")
    ap.add_argument("--dry-run", action="store_true", help="print the ticket without posting it")
    args = ap.parse_args()

    files = [f.lstrip("@") for f in args.files]
    for p in files:
        if not os.path.isfile(p):
            sys.exit(f"not a file: {p}")

    host, owner, repo = parse_remote(args.repo) if args.repo else (None, None, None)
    if not host:
        host, owner, repo = parse_remote(None)

    token = load_token(host, args.token)
    sha = run("git", "rev-parse", "HEAD")
    short = sha[:7]
    commit_url = f"https://{host}/{owner}/{repo}/commit/{sha}"

    desc = args.description.strip()
    title = (args.title or desc).strip().splitlines()[0] if desc else "(no description)"
    labels = resolve_labels(host, token, owner, repo, [l for l in args.label if l])
    seed = f"{desc}\n\n**Linked commit:** [{short}]({commit_url}) (`{sha}`)"

    # Preview only: no issue is created and nothing is uploaded.
    if args.dry_run:
        att_line = "\n".join(f"- {os.path.basename(p)}" for p in files) or "(none)"
        body = seed + "\n\n**Attachments:**\n" + att_line
        print("=== DRY RUN (nothing created) ===")
        print(f"repo:    {owner}/{repo}")
        print(f"commit:  {commit_url}")
        print(f"title:   {title}")
        print(f"labels:  {[l for l in args.label if l] or '(none)'}")
        print(f"attach:  {att_line}")
        print("=== body ===")
        print(body)
        return 0

    # Create the issue first (Gitea attaches files to an existing issue).
    issue = create_issue(host, token, owner, repo, title, seed, labels)
    number = issue["number"]

    attached = []
    missing = False
    for p in files:
        url = attach(host, token, owner, repo, number, p)
        if url is None:
            missing = True
        else:
            attached.append((os.path.basename(p), url))

    if missing and not attached:
        print(
            "ERROR: attachment endpoint returned 403/404 — attachments are disabled on this "
            "instance (admin setting `[attachment] ENABLED = true` in app.ini; there is no "
            "web-UI toggle). Enable it and re-run. The issue was created but has no attachments.",
            file=sys.stderr,
        )
        return 2

    if attached:
        body = seed + "\n\n**Attachments:**\n" + "\n".join(f"- [{n}]({u})" for n, u in attached)
        patch_url = f"https://{host}/api/v1/repos/{owner}/{repo}/issues/{number}"
        requests.patch(patch_url, json={"body": body},
                       headers={"Authorization": f"token {token}"})
    if missing:
        print(f"warning: {sum(1 for _ in range(0)) + (len(files) - len(attached))} file(s) could not be attached (instance may have attachments disabled)",
              file=sys.stderr)

    print(f"Created: {issue.get('html_url', '')}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
