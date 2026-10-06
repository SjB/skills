---
name: orchestrate-herdr
description: "Drive a plan from context or @file through a published spec, linked tickets, and one-at-a-time isolated implementation to a merged PR using Herdr and Pi agents."
disable-model-invocation: true
---

# Orchestrate plans to merged PRs with Herdr

Turn a plan into a published spec and child tickets, then drive one tracker ticket at a time through isolated implementation, independent verification, four-axis review, and merge. The worker node is the source of truth for run state, so a later orchestrator system can reconnect and resume.

This skill is a **routing and safety contract**. Operational detail lives in `references/`:

- `references/dispatcher.md` — select and validate the worker node, local or remote, and discover Herdr state before dispatch.
- `references/run-loop.md` — plan and publish, then the one-at-a-time task loop: claim, implement, verify, review, fix, merge, close.
- `references/state.md` — the `.orchestrate/<slug>` state directory, recovery, cross-system sync, and cleanup.

Read the reference for the phase you are in before acting in it.

## Prerequisites

- Herdr, Pi, Git, and a forge CLI (`tea`, `gh`, or `glab`) reachable from the worker node. Run the `forge-cli` preflight in the target repo.
- This skill discoverable in the worker node's Pi session. If the worker node is remote, confirm it before dispatching.
- The target repository, Git, and credentials on the worker node.
- If any prerequisite is missing on the selected node, stop with actionable setup guidance. Do not dispatch to an unprepared shell.

## Roles

Keep roles distinct. Never let one role do another's work.

- **Orchestrator system** — the machine where this skill is invoked. Invokes and observes the workflow.
- **Worker node** — the user-selected machine that runs the planner and worker agents and owns repository work. Local or remote, chosen at invocation. It is authoritative for run state.
- **Worker agent** — a subagent (or remote Herdr pane running Pi) that implements or verifies a scoped task.
- **Planner** — the agent that runs this loop. Coordinates and verifies state; does not edit product code or merge. Workers do not merge unless assigned an explicit merge task.

## Phase 0 — Select and validate the worker node

The worker node is authoritative for run state, so pick it before anything else.

1. Select the worker node: the current machine for a local run, or a remote machine the user names. If the user did not select one and the environment is ambiguous, ask.
2. If the node is remote, follow `references/dispatcher.md`: discover the Herdr session and pane, inspect the exact target and its repository/ref before dispatch, and confirm the node has this skill, Git, and a forge CLI. Never infer a pane ID, target a pane by display label alone, or touch unrelated panes.
3. If the node, session, or repository is missing, ambiguous, or not ready, stop and say exactly what is missing. Do not guess.

The worker node is ready when its checkout identifies the target repository, its forge CLI authenticates, and Herdr can reach the same named session.

## Phase 1 — Plan and publish

Work from the current conversation or an `@file` the user passes. If a reference is passed, fetch its full body and comments first.

1. **Spec.** Run the `to-spec` skill to synthesize the current conversation into a spec and publish it to the current repository's tracker. Apply the `ready-for-agent` label. This is the durable record of the goal and acceptance criteria.
2. **Tickets.** Run the `to-tickets` skill to break the spec into tracer-bullet tickets, each declaring its blocking edges, published to the same tracker in dependency order. Apply `ready-for-agent`. Each ticket is a complete, verifiable slice with acceptance criteria.

Do not modify the spec after publishing except to record decisions. The spec and tickets are the scope; the loop below never widens it.

## Phase 2 — Run one task at a time

Process **one** in-scope, open, unblocked ticket at a time. See `references/run-loop.md` for the full loop. The loop, in order:

1. **Select the frontier.** Only in-scope, open, unblocked tickets. Claim it before implementing; re-query tracker state as work advances.
2. **Isolate.** Give the task one Git worktree and branch per `worktrees`. Never parallel-write a shared checkout.
3. **Implement.** Dispatch a worker with the full ticket, acceptance criteria, scope boundaries, and any upstream handoffs. The worker works without access to another agent's conversation.
4. **Verify.** For meaningful behavior changes, run an independent verifier that reports evidence; a worker's self-report is not enough.
5. **Review.** Run all four axes — `dual-review` (correctness/security, maintainability) and `code-review` (spec, standards) — before merge.
6. **Fix.** Send actionable findings to a scoped fix worker and recheck. Cap at **three** fix rounds; unresolved findings stop for human judgment.
7. **Merge.** Only after all four axes pass, required local checks pass, CI is green when available, the target branch is still correct, and no human decision remains. Link the ticket in the PR.
8. **Close.** Close the task ticket with a recorded outcome.

Cross-cutting rules that apply through the loop (full detail in `references/run-loop.md`):

- **Retries.** Retry transient infrastructure failures only, at most two after the first attempt (three total). Keep this budget separate from the three fix rounds. Never blindly retry semantic failures, failed checks, or rejected reviews — correct the cause first.
- **Uncertain side effects.** Reconcile the tracker, Git, worker node, or Herdr state before repeating an operation. If the outcome stays uncertain, stop and escalate; do not blindly replay non-idempotent operations.
- **Escalate** immediately for authentication/permission failures, unresolved state mismatches, exhausted retry or fix limits, unsafe ambiguity, or any decision requiring human judgment. Preserve state and evidence at every escalation.

### Finish

Close the parent spec ticket only when every in-scope task is complete, merged, verified, and run state is safely persisted. Leave it open when any work is blocked, failed, or unresolved.

## Recovery

On restart, follow `references/state.md`: inspect the persisted `.orchestrate/<slug>` state and native Herdr status before creating or restarting agents. A new orchestrator system syncs state from the worker node before resuming; a local copy is not authoritative. Never duplicate work solely because a planner session restarted.

## Cleanup

At completion, follow `references/state.md`: remove only clean task worktrees and close only run-owned Herdr panes. Preserve dirty or unresolved worktrees and the retained state. Retained state is deleted only by explicit user action.

## Reporting

Report merged work, PR links, verification evidence, human handoffs, blockers, and remaining work. Report `done` only when every in-scope task is merged, verified, and state is persisted.
