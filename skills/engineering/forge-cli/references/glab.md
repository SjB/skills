# GitLab CLI recipe

Use `glab` commands in the current repository. Use JSON output for reads and file-backed descriptions for multiline bodies.

## Read

```bash
glab issue view ID --comments --output json
glab issue list --all --per-page 100 --output json
glab mr view PR --comments --output json
```

Native parent, child, and dependency fields may be unavailable. If absent, use the explicit links documented in the ticket.

## Issue lifecycle

```bash
glab issue update ID --assignee USER
glab issue update ID --label NEW --unlabel OLD
glab issue note ID --message "$(cat BODY_FILE)"
glab issue close ID
```

`--assignee USER` replaces existing assignees; prefix with `+` to add without replacing.

## Merge request lifecycle

```bash
glab mr create --target-branch BASE --source-branch HEAD --title TITLE --description-file BODY_FILE --yes
glab mr note create PR --message "$(cat BODY_FILE)"
glab mr merge PR --squash --remove-source-branch --auto-merge=false --yes
```

Use `glab mr note create` for review findings or requested changes. Re-read the issue/MR after every mutation. Do not use auto-merge or bypass options.
