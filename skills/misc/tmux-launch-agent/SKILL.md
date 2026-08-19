---
name: tmux-launch-agent
description: Fork a new agent CLI session into a new tmux window, detected from the current agent.
disable-model-invocation: true
---

## Agent CLI Seed Data

Agent config (binary, `args`, `modelflag`) is in [`agents-seed.md`](agents-seed.md). Step 2 reads it by `name`.

## Dispatch

1. **Detect agent** — Run `./detect-agent` (sibling). On success, the agent name is known. On failure (exit 1), stop.

2. **Look up config** — Find the agent's entry in [`agents-seed.md`](agents-seed.md) by `name`. Extract `binary`, `args`, and `modelflag`.

3. **Parse flags** — Scan user arguments for flags (before prompt text). For each flag, extract its value and remove both the flag and value from the argument list:
   - `--name <title>` / `-n <title>` — tmux window title
   - `-c <path>` — working directory (default: project directory)
   - `--model <name>` / `-m <name>` — model for child session

   Remaining text is the prompt. If `--name` is absent, tmux auto-names the window.

4. **Build command** — Assemble the inner command:
   - Start with `<binary>`.
   - If model specified: append `<modelflag> <model-name>`.
   - If prompt exists and `args` contains `{prompt}`: write to `/tmp/`, substitute path for `{prompt}`.
   - If prompt exists and `args` is empty: pipe via `echo`.
   - If no prompt: launch bare.

5. **Open window** — Call `./tmux-open <window-name> <start-dir> <inner-command>` where `<inner-command>` is the assembled command from step 4 as separate arguments. On success, a new tmux window appears with the agent session active.
