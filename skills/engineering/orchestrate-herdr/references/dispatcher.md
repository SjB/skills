# Dispatcher: resolve the worker and start fresh

Invocation is `/skill:orchestrate-herdr <spec-ticket> [worker]` (for example, `/skill:orchestrate-herdr 32 obelix`). The spec ticket is required; the worker is optional. If the worker is omitted or blank, use the current local worker and spawn the agent there. If a worker is named, resolve it from `herdr machine list`; if it is missing or ambiguous, stop and ask. Do not silently select a different worker.

Always start a **new agent** for this orchestration and each dispatched task. Never reuse or resume an existing agent, even if one appears idle or already in the right repository.

## Validate the target

1. For a named worker, run `herdr machine list` and match it to an available saved machine. Use that exact label or ID with `herdr --machine <worker> ...`; do not treat arbitrary SSH hostnames as valid machine selectors. For the default local worker, stay on the current worker and spawn the agent locally.
2. For a named worker, confirm the machine is reachable; for the default local worker, inspect the current local Herdr session. In either case, inspect workspaces, panes, and agents. Discover the target repository and ref; do not guess pane IDs, repo paths, or agent kinds.
3. Confirm the spec ticket exists on the target repository's tracker and is the parent/spec ticket. The new planner must read the spec, linked tickets, and relevant comments before creating work.
4. Confirm the target has this skill, Pi, Git, repository credentials, and an authenticated forge CLI (run the `forge-cli` preflight). Stop with actionable guidance if not.

Run `herdr --skill` to discover the installed Herdr skills and follow the relevant skill for CLI workflows; use CLI help for exact command syntax. Machine commands require a configured, enabled machine profile and a reachable, API-compatible Herdr server. A connection failure does not prove a mutation failed; inspect remote state before retrying.

## Start a new planner

Choose a pane in the target repository only as the source for creating a **new sibling pane**. Do not send work to any existing agent pane. Create the new pane with the confirmed repository working directory, read its returned pane ID, then start a fresh Pi agent there using the installed agent kind. If there is no suitable source pane or no available shell in the new pane, stop rather than commandeering an unrelated pane.

Submit the exact invocation to that new agent, using the spec ticket and resolved worker (omit the worker when using the current local worker):

```text
/skill:orchestrate-herdr <spec-ticket> [worker]
```

Confirm the fresh agent reaches `working` before reporting kickoff success. If startup or submission is uncertain, inspect that new pane/agent before retrying; do not create a duplicate agent blindly. Once the planner is working, report the worker, spec ticket, and new agent/pane, then stop monitoring the full workflow.
