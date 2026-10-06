---
name: feedback-bundle
description: Post a Gitea feedback issue linked to the current commit and attach logs or screenshots. Use when the user reports a problem and asks to file it with evidence, open a bug ticket, or says "feedback-bundle" or "attach the log".
---

# Feedback Bundle

Create a Gitea issue in the current repository, linked to its current `HEAD`, with optional files attached.

## Run

Run from the repository the issue should belong to, using `feedback_bundle.py` beside this file:

```sh
python3 <skill-dir>/feedback_bundle.py "Describe the problem" @app.log @screenshot.png
```

The script requires Python `requests`. Without `--token`, it reads the matching host token from `~/.config/tea/config.yml` and requires PyYAML. The default repository is read from `git remote get-url origin`.

Common options:

```sh
python3 <skill-dir>/feedback_bundle.py "Description" @log.txt \
  --title "Short issue title" --label bug --dry-run
```

- `@file` — attach an existing file; paths are resolved from the current working directory. The `@` is optional.
- `--title` — override the default title (the description's first line).
- `--label` — add a label; repeat to add more. Labels are resolved against the repository's Gitea labels; unknown labels are skipped with a warning.
- `--repo` — override the remote URL. Use a full Git remote URL (SSH, SCP-style, or HTTPS), not an `owner/repo` slug.
- `--token` — provide a Gitea token instead of reading tea config.
- `--dry-run` — print the issue preview without creating an issue or uploading files. Authentication is still loaded; labels require an API request.

## What happens

1. The script reads `HEAD`, repository host/owner/name, and authentication.
2. It creates an issue whose body includes a link to that exact commit.
3. It uploads each attachment to the issue and adds download links to the body.

Gitea only accepts issue attachments after an issue exists. If uploads fail because attachments are disabled (403/404), the issue already exists without the files; enable attachments on the Gitea instance, then attach the files to that issue manually. The instance setting is `[attachment] ENABLED = true` in `app.ini` (or `ATTACHMENTS_ENABLED`), not a web UI toggle.
