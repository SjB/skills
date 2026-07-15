---
name: commit-staged
description: Commit staged files with a conventional commit message.
disable-model-invocation: true
---

## Process

1. **Check the staging area** — Run `git diff --cached --stat`. If empty, report "nothing staged" and stop.

   Completion criterion: Staged files are listed, or the skill terminates.

2. **Draft the message** — Inspect `git diff --cached` to understand what changed. Write a [conventional commit](https://www.conventionalcommits.org/) message:

   - Format: `type(scope): summary` — scope is optional.
   - Common types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`, `style`, `perf`, `ci`, `build`.
   - Summary: imperative mood, lowercase, no period, ≤72 characters.
   - Body (if needed): wrap at 72 characters, explain _what_ and _why_, not _how_.

   Completion criterion: A conventional commit message is composed.

3. **Commit** — Run `git commit -m "<message>"`. If the commit fails, report the error and stop.

   Completion criterion: `git commit` exits 0.

4. **Report** — Print the short commit hash and the first line of the message.

   Completion criterion: The hash and message are printed.
