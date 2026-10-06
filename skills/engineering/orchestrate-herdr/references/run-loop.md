# Run loop: one ticket at a time

The loop drives one tracker ticket through implementation, verification, review, and merge, then moves to the next. The tracker is the source of truth; read the spec, the current ticket, and its comments before acting.

## Scope control

The spec and tickets are the scope. Never widen it. For a supplied ticket, inspect only that ticket; do not process its siblings, parent, or descendants. Re-query tracker state as work advances; a ticket's status or blockers may have changed since it was selected.

## 1. Select the frontier

Select only in-scope, open, unblocked tickets. Use native blocker/dependency relationships; otherwise require explicit blocker markers or linked URLs. Never infer order from titles. Claim the selected ticket before implementing.

## 2. Isolate

Give the task one Git worktree and branch. Use the current checkout when the worker node is local; when remote, use the canonical `.bare` worktree layout and the agreed owner/repository worktree location. Create a branch such as `issue-<N>-<slug>` on a clean base; never reuse a dirty worktree. Never parallel-write a shared checkout.

## 3. Implement

Dispatch one worker per task with a self-contained prompt: its role and one scoped outcome, the overall goal for context, allowed/forbidden paths and acceptance checks, its worktree path and starting branch, any upstream handoffs, and instructions to run focused checks, commit on the task branch, and not merge/rebase/open a PR unless the task explicitly requires it. The worker receives the full ticket, acceptance criteria, scope boundaries, and required upstream handoffs — no access to another agent's conversation.

## 4. Verify

For meaningful behavior changes, run an independent verifier that runs the checks and reports evidence. The verifier must not modify the target source; its evidence overrides a worker's self-report. Name the target, branch, acceptance criteria, and an exact recipe — concrete commands or repro steps, not "test it."

## 5. Review — four axes

Run all four axes before merge. `code-review` covers **spec** (does the code match the originating issue?) and **standards** (does it follow the repo's documented standards?). `dual-review` covers **correctness/security** and **maintainability**. All four must pass before merge.

Run the review against the base branch and the task's diff. Post findings through the tracker/PR comment or review function and link them from the ticket.

## 6. Fix rounds

Send actionable findings to a scoped fix worker and recheck. Cap at **three** fix rounds; unresolved findings stop for human judgment rather than guessing. Keep this budget separate from the retry budget below.

## 7. Merge

Merge only after every gate passes:

- all four review axes pass and findings are resolved;
- required local checks pass;
- CI is green when available (the current Gitea host has no CI; this gate is silent when CI is absent);
- the target branch is still the expected default branch;
- no human decision or blocker remains.

Create exactly one PR per task and link the ticket's number and title in it. Do not use auto-merge, admin/bypass, or force. Merge after every gate passes; never merge around a failed check, unresolved finding, or missing decision.

## 8. Close

Close the task ticket with a recorded outcome once its PR is merged and completion is verified. Leave it open when any in-scope work is blocked, failed, or unresolved.

## Retries

Retry transient infrastructure failures only, at most two retries after the first attempt (three total). Keep this budget separate from the three fix rounds. Never blindly retry semantic failures, failed checks, or rejected reviews — correct the cause first. Cap retries; do not respawn indefinitely.

## Uncertain side effects

For an uncertain side effect, reconcile the tracker, Git, worker node, or Herdr state before repeating the operation. If the outcome stays uncertain, stop and escalate; do not blindly replay non-idempotent operations. Reconciliation prevents duplicate agents, worktrees, comments, PRs, merges, or state transitions.

## Escalation

Escalate immediately, preserving state and evidence:

- authentication or permission failures;
- unresolved state mismatches;
- exhausted retry or fix limits;
- unsafe ambiguity;
- any decision requiring human judgment.

For a human decision or judgment call, assign the ticket to the configured human reviewer, mark it for human review, and comment the exact request. If no human identity is configured, ask before assigning; never invent one.

## Finish

When every in-scope task is complete, merged, and verified, close the parent spec ticket and record that run state is safely persisted. Report merged work, PR links, verification evidence, human handoffs, blockers, and remaining work. Report `done` only when no in-scope work remains.
