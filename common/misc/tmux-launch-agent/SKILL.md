---
name: tmux-launch-agent
description: Fork a new agent CLI session into a new tmux window, detected from the current agent.
disable-model-invocation: true
---

## Agent CLI Seed Data

The agent config (binary, `args` convention per agent) and field meanings are in [`agents-seed.md`](agents-seed.md). Step 2 reads it to find the calling agent's entry.


## Process

1. **Detect the calling agent** — Run `./detect-agent` (sibling to this skill). If it exits 1 (agent unknown), report the failure and stop — the agent name is required.

   Completion criterion: The agent name is known and non-empty.

2. **Look up the agent config** — Find the agent's entry in [`agents-seed.md`](agents-seed.md) by `name`. Extract its `binary` and `args` fields.

   Completion criterion: The agent's entry is found and its `binary` and `args` are known.

3. **Parse flags** — Scan the user's arguments for optional flags (which must come before the prompt text):
   - `--name <title>` or `-n <title>` — the tmux window title. Extract the title and remove the flag and its value from the arguments list.
   - `-c <path>` — the working directory for the new window. Extract the path and remove the flag and its value from the arguments list.

   The remaining text after stripping both flags is the prompt for the child agent.

   If `--name`/`-n` is absent, tmux auto-names the window.
   If `-c` is absent, the new window inherits the current pane's working directory.

   Completion criterion: The arguments are split into an optional window name, an optional directory path, and the remaining prompt text.

4. **Build the inner command** — Combine the agent config with the remaining user-supplied prompt arguments. The `args` template determines how the prompt is delivered:

   - **Prompt-file agents** (`args` contains `{prompt}`) — Write the prompt text to a temporary file under `/tmp/` and substitute the file path for `{prompt}` in the args template. For example, an agent with `args: "@{prompt}"` becomes `<binary> @/tmp/tmux-launch-XXXX.md`.
   - **Stdin-pipe agents** (`args` is empty) — Pipe the prompt text via `echo` into the binary.
   - **No prompt** — If the user passed no arguments (after removing flags), launch the binary bare (interactive start) with no prompt file or pipe.

   Completion criterion: The inner command is correctly built per the target agent's `args` convention (prompt-file, stdin-pipe, or bare).

5. **Wrap with the environment runner** — Detect whether `mise` is available via `command -v mise`:

   - **mise available** — Wrap the inner command as `mise x --allow-env='*' -- <inner-command>`.
   - **mise absent** — Wrap the inner command as `$SHELL -c '<inner-command>'`.

   Completion criterion: A valid shell command string is ready.

6. **Fork into a new tmux window** — Build and run:
   ```
   tmux new-window <name-flag> <dir-flag> "<shell-command>"
   ```
   - `<shell-command>` — the wrapped command from step 5.
   - `<name-flag>` — `-n "<title>"` if a window name was parsed in step 3, omitted otherwise.
   - `<dir-flag>` — `-c <path>` if a directory was parsed in step 3, omitted otherwise.

   Completion criterion: `tmux new-window` exits 0 and a new tmux window appears with the agent CLI session active.

