# Issue tracker: Gitea

Issues and PRDs for this repo live as Gitea issues. Use the `gitea` CLI for all operations.

## Conventions

- **Create an issue**: `tea issue create --title "..." --description "..."`. Use a heredoc for multi-line descriptions. 
- **Read an issue**: `tea issue <number> --comments`. Use `-o json` for machine-readable output.
- **List issues**: `tea issue list --state open -o json` with appropriate `--labels` and `--state` filters. 
- **Comment on an issue**: `tea comment <number> "..."`.
- **Apply / remove labels**: `tea issue edit <number> --add-label "..."` / `--remove-label "..."`. Multiple labels can be comma-separated or by repeating the flag.les
- **Close**: `tea issue close <number>`. `tea issue close` does not accept a closing comment, so post the explanation first with `tea comment <number> "..."`, then close.

Infer the repo from git remote -v — `tea` does this automatically when run inside a clone.

## Pull requests as a triage surface

**PRs as a request surface: no.** _(Set to `yes` if this repo treats external PRs as feature requests; `/triage` reads this flag.)_

When set to `yes`, PRs run through the same labels and states as issues, using the `gh pr` equivalents:

- **Read a PR**: `tea pr <number> --comments` and `tea api /repos/{owner}/{repo}/pulls/<number>.diff`  for the diff.

- **List external PRs for triage**: `tea pr list --state open -o json ` then keep only PRs whose author is not a project member/owner (a contributor's MR, not a maintainer's in-flight work).
- **Comment / label / close**: `tea comment <number> "..."`, `tea pr edit --add-label`/`--remove-label`, `tea pr close`.

Gitea shares one number space across issues and PRs, so a bare `#42` may be either — resolve with `tea pr 42` and fall back to `tea issue 42`.

## When a skill says "publish to the issue tracker"

Create a Gitea issue.

## When a skill says "fetch the relevant ticket"

Run `tea issue <number> --comments`.
