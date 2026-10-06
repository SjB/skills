# Dispatcher: select and validate the worker node

The dispatcher is one-shot. It selects the worker node, discovers and validates Herdr state, and kicks off the planner. It does not run the loop afterward.

## Local vs remote

- **Local worker node** — the orchestrator system is the worker node. Use the current repository checkout. Skip the Herdr discovery below and run the planner in this session.
- **Remote worker node** — the user names another machine. Discover its Herdr session, workspace, and pane, confirm the repository/ref, then start the planner there.

If the user did not select a node and the environment does not make it obvious, ask. Do not default to a guess.

## Preconditions

- Check Herdr access on the node: `HERDR_ENV=1`, `HERDR_WORKSPACE_ID`, and that the `herdr` CLI can reach the same named session.
- Resolve the explicit session from `HERDR_SESSION`; if unset, inspect `herdr session list` and ask if more than one plausible session exists. Pass `--session <name>` to every Herdr command; the environment variable alone can fall back to another server.
- Confirm the node has this skill discoverable, plus Git and a working forge CLI (run the `forge-cli` preflight). If not, explain the setup needed; do not dispatch to an unprepared shell.

## Discover, do not guess

Never infer a pane ID, an agent status, or a repository path. Discover and inspect them first. Do not close, rename, move, or reconfigure unrelated panes.

```bash
herdr --session "$SESSION" session list
herdr --session "$SESSION" pane list --workspace "$HERDR_WORKSPACE_ID"
herdr --session "$SESSION" pane read <pane-id> --source recent-unwrapped --lines 200
```

Before dispatching, confirm the target pane is the intended remote Pi pane and that its repository/ref is correct. Inspect the exact target and repository/ref before dispatch — work starts in the intended environment, never a guessed one.

## Kick off the planner

Confirm the node has `orchestrate-herdr` available. If not, stop and explain that this skill must be installed or discoverable in the remote Pi session.

Send the root kickoff as a separate text action followed by Enter; a TUI paste burst can swallow Enter. Use the exact pane ID returned by Herdr, never a guessed ID.

```bash
herdr --session "$SESSION" pane send-text <pane-id> "/skill:orchestrate-herdr You are the root planner for: <goal>"
# After the text is present in the pane:
herdr --session "$SESSION" pane send-keys <pane-id> enter
herdr --session "$SESSION" agent wait <pane-id> --until working --timeout 120000
```

If the text was not submitted, inspect the pane and dismiss any slash-command popup with `escape`; do not blindly resend and create duplicate runs. Never claim kickoff succeeded on changed pane text alone: confirm native status became `working`.

Wait for Herdr's native `working` status, then report the root pane/session and stop. Do not wait for the whole orchestration tree.
