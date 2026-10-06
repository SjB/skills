# State, recovery, and cleanup

Run state lives under a run-scoped `.orchestrate/<slug>` directory in the worker node's repository checkout. The worker node is the source of truth. Keep this state out of product commits and PRs.

## State directory

Create `.orchestrate/<slug>/` on the worker node:

- `plan.json` — the original goal, repo path/URL, base ref, acceptance criteria, and task definitions (name, type, scoped goal, dependencies, path boundaries, acceptance, verification recipe, retry cap).
- `state.json` — each task's status, attempt count, worktree path, branch, Herdr session/workspace/pane IDs, and handoff path.
- `handoffs/<task>.md` — each agent's final response, saved verbatim with task, branch, and execution metadata.
- `recovery.log` — spawns, recovery, reconciliation, and operator decisions.

Use kebab-case task names. Validate that dependencies and verifier targets exist and that the dependency graph has no cycles before starting work.

## Persist immediately

Persist state immediately after every side effect and record enough Herdr, branch, worktree, and task identity to reconcile execution after interruption. On restart, inspect persisted state and native Herdr status before creating or restarting agents. Never duplicate work solely because a planner session restarted.

A new orchestrator system reconnects to the worker node and syncs from it before resuming; a local copy is not authoritative. Do not create a separate Git branch solely to transfer this state.

## Recovery

On restart, in order:

1. Read `plan.json`, `state.json`, and `handoffs/`.
2. Discover native Herdr state and reconcile stored IDs with what Herdr actually reports.
3. Reconcile tracker and Git state.
4. Reattach to running agents; never duplicate a task just because the session restarted.

If reconciliation cannot resolve a state mismatch, stop and escalate rather than guessing.

## Handoffs

Handoffs are the only information channel between workers and planners. Save each final response verbatim; add a short metadata comment above it with task, branch, worktree, and Herdr identifiers. Do not paraphrase the evidence.

- **Worker** — status (`success`/`partial`/`blocked`), actual branch, what it did, acceptance with evidence, verification tier, commands run, concerns, suggested follow-ups. A worker commits to its task branch and does not merge/rebase/open a PR unless the task requires it. Do not accept `success` if stated acceptance is unmet or evidence is absent.
- **Verifier** — verification tier, target, execution, findings per criterion (met/not met/n/a) with severity, and environment limits. `verifier-blocked` means the environment prevented a meaningful check; `verifier-failed` means the check ran and the target did not pass. Do not downgrade a failure to a blocked verdict.
- **Planner** — an aggregated handoff to the parent: status, actual deliverable branch, one bullet per meaningful slice, strongest evidence actually produced, risks, and parent-scope follow-ups.

## Cleanup

At completion, remove only what this run owns and leave everything else untouched.

- **Remove** clean task worktrees (via `git worktree remove`, after accounting for every staged, unstaged, and untracked change) and close only Herdr panes created by this run.
- **Preserve** dirty or unresolved worktrees — cleanup cannot destroy unfinished work or recovery evidence.
- **Retain** the worker node's canonical checkout, `.orchestrate/<slug>` state, handoffs, and logs. Never delete retained state automatically. Cleanup of retained state requires an explicit user action.
- Leave unrelated Herdr panes, tickets, repositories, branches, and PRs untouched.
