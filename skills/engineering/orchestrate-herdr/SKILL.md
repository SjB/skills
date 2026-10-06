---
name: orchestrate-herdr
description: "Implement a published spec ticket using Herdr and Pi agents. Use with /skill:orchestrate-herdr <spec-ticket> [worker], such as /skill:orchestrate-herdr 32 obelix; omitted worker uses the current local worker."
disable-model-invocation: true
---

# Orchestrate a spec with Herdr

Invocation requires `<spec-ticket>` and optionally accepts `[worker]`. Example: `/skill:orchestrate-herdr 32 obelix`. If the worker is omitted or blank, use the current local worker; otherwise resolve it against `herdr machine list`. Always start a fresh agent for this invocation and for each dispatched task; never reuse or resume an existing agent. The selected worker owns execution and persisted run state.

**Start by reading the spec ticket and its linked tickets.** Follow the `implement-spec` flow: understand the task graph, create one integration branch, implement ready tickets in isolated worktrees, merge completed work onto the integration branch, and continue as the frontier advances. If there are no linked implementation tickets forming an actionable frontier, invoke `/to-tickets` and follow its approval and publishing process; otherwise, don't create or rewrite tickets.

This skill is a routing and safety contract. Read the relevant reference before acting:

- `references/dispatcher.md` — validate the named worker and discover the exact Herdr session and pane.
- `references/run-loop.md` — spec-first, integration-branch implementation flow.
- `references/state.md` — persisted state, recovery, cross-system sync, and cleanup.

## Prerequisites and roles

The selected worker must have this skill, Herdr, Pi, Git, the target repository and credentials, and an authenticated forge CLI (`tea`, `gh`, or `glab`). Run the `forge-cli` preflight there. If anything is missing or ambiguous, stop with actionable guidance; do not guess or dispatch. Start a fresh agent in a newly created pane; do not route work to an existing agent.

- **Orchestrator** invokes and observes the workflow.
- **Worker node** is the named machine and source of truth for run state.
- **Planner** coordinates and verifies; it does not edit product code or merge.
- **Implementer/merger agents** work only in assigned scopes; no worker merges unless assigned the merger task.

## Run and finish

1. Validate the spec ticket and optional worker. Read the spec, all associated tickets, and relevant comments before creating agents or branches.
2. Follow `references/run-loop.md`; keep all work within the spec and linked tickets. Preserve state and evidence on blockers, failures, or human decisions.
3. On restart, follow `references/state.md` and reconcile worker-side state before resuming; never duplicate work because the planner restarted.
4. At completion, clean only clean implementer worktrees and run-owned Herdr panes. Retain state unless the user explicitly asks to delete it.

Report the integration branch or PR, completed tickets, verification/review evidence, blockers, human handoffs, and remaining work. Say `done` only when all tickets are complete and the final review has passed.
