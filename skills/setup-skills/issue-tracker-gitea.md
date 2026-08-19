# Issue tracker: Gitea

Issues and PRDs for this repo live as Gitea issues. Use the `tea` CLI for all operations.

## Conventions

- **Create an issue**: `tea issue create --title "..." --description "..."`. Use a heredoc for multi-line descriptions. 
- **Read an issue**: `tea issue <number> --comments`. Use `-o json` for machine-readable output.
- **List issues**: `tea issue list --state open -o json` with appropriate `--labels` and `--state` filters. 
- **Comment on an issue**: `tea comment <number> "..."`.
- **Apply / remove labels**: `tea issue edit <number> --add-label "..."` / `--remove-label "..."`. Multiple labels can be comma-separated or by repeating the flag. Labels need to be created first with `tea label create --name "..." --color "..."`.
- **Close**: `tea issue close <number>`. `tea issue close` does not accept a closing comment, so post the explanation first with `tea comment <number> "..."`, then close.

Infer the repo from git remote -v — `tea` does this automatically when run inside a clone.

## Pull requests as a triage surface

**PRs as a request surface: no.** _(Set to `yes` if this repo treats external PRs as feature requests; `/triage` reads this flag.)_

When set to `yes`, PRs run through the same labels and states as issues, using the `tea pr` equivalents:

- **Read a PR**: `tea pr <number> --comments` and `tea api /repos/{owner}/{repo}/pulls/<number>.diff` for the diff.
- **List external PRs for triage**: `tea pr list --state open -o json` then keep only PRs whose author is not a project member/owner (a contributor's MR, not a maintainer's in-flight work).
- **Comment / label / close**: `tea comment <number> "..."`, `tea pr edit --add-label`/`--remove-label`, `tea pr close`.

Gitea shares one number space across issues and PRs, so a bare `#42` may be either — resolve with `tea pr 42` and fall back to `tea issue 42`.

## When a skill says "publish to the issue tracker"

Create a Gitea issue.

## When a skill says "fetch the relevant ticket"

Run `tea issue <number> --comments`.

## Wayfinding operations

Used by `/wayfinder`. The **map** is a single issue with **child** issues as tickets.

- **Map**: a single issue labelled `wayfinder:map`, holding the Notes / Decisions-so-far / Fog body. `tea issue create --label wayfinder:map`.
- **Child ticket**: an issue linked to the map as a GitHub sub-issue (`tea api` on the sub-issues endpoint). Where sub-issues aren't enabled, add the child to a task list in the map body and put `Part of #<map>` at the top of the child body. Labels: `wayfinder:<type>` (`research`/`prototype`/`grilling`/`task`). Once claimed, the ticket is assigned to the driving dev.
- **Blocking**: GitHub's **native issue dependencies** — the canonical, UI-visible representation. Add an edge with `tea api --method POST /repos/{owner}/{repo}/issues/<child>/dependencies -F index=<blocker-issue-number> -F repo=<blocker-repo-name> -F owner=<bocker-owner-name>`, where `<blocker-usse-number>` is the blocker's numeric **issue number** (`tea api repos/{owner}/{repo}/issues/<n> --jq ".number. .repository.name, .repository.owner"`, where `.number` is the `<blocker-issue-number>`, `.repository.name` is the `<blocker-repo-name>` and `.repository.owner` is the `<blocker-repo-owner>`. Where dependencies aren't available, fall back to a `Blocked by: #<n>, #<n>` line at the top of the child body. A ticket is unblocked when every blocker is closed.
- **Frontier query**: list the map's open dependencies (`tea api /repos/{owner}/{repo}/issues/<n>/dependencies | jq '.[] | select(.state = "open") .number'`, scoped to the map's sub-issues / task list), drop any with an open blocker (`list of dependencies is not empty`, or an open issue in the `Blocked by` line) or an assignee; first in map order wins.
- **Claim**: `tea issue edit <n> --add-assignees @me` — the session's first write.
- **Resolve**: `tea comments <n> "<answer>"`, then `tea issue close <n>`, then append a context pointer (gist + link) to the map's Decisions-so-far.
