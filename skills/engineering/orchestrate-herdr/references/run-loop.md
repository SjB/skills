# Run loop: implement a spec ticket

The spec and linked tickets define scope; the tracker is the source of truth. The planner's first action is to set/verify the parent issue's `in-progress` label. Then read the spec, every associated ticket, blockers, and relevant comments. If the spec has no linked implementation tickets forming an actionable frontier, invoke `/to-tickets` and follow its approval and publishing process before implementation. If tickets are blocked, don't invent extra work.

The issue tracker should have been provided. If not, tell the user to run `/setup-skills`.

The goal is the entire spec implemented on one **integration branch**, with each ticket resolved according to tracker semantics. Treat tickets as a dependency graph; re-query the tracker as the ready frontier changes. If no ticket is actionable, report the blocker rather than guessing.

## Communication

All agent communication and handoffs go through tracker or PR comments; `.orchestrate/<slug>/events.jsonl` is only the operational event log. Keep comments concise and link to context rather than copying ticket bodies or pane output.

- Implementers post their completion handoff or blocker on the task issue, including branch/commit, changed files, acceptance evidence, checks, and concerns.
- Reviewers put review discussion on the PR. Record the review outcome on the task issue.
- The planner posts parent-spec comments at meaningful milestones: implementation ready, review outcome, merge, actionable blocker, and completion. Don't repeat comments already posted by a worker.
- The monitor posts only unreported actionable mismatches or blockers. It does not send agent prompts or take recovery actions.

## 1. Read and establish the integration branch

- Confirm the supplied issue is the parent/spec ticket and identify linked implementation tickets.
- Understand the task graph and current frontier. Re-query tracker state as work advances.
- When tickets require codebase or external-documentation exploration, use an exploration agent and put concise findings in the relevant tracker comment for later agents to reference.
- Create one integration branch from the intended target branch. If a PR is required, open a draft after the first implementation merge and link it to close the spec and tickets.
- If a ticket or its dependencies are ambiguous, stop and ask rather than infer.

## 2. Implement the frontier

For each open, unblocked ticket, start a **new worker subagent** in its own worktree and branch. Independent frontier tickets may run concurrently; never parallel-write a shared checkout. Start a fresh merger agent for each merge.

Start each implementer with its role, task-issue URL, worktree path, and starting branch; the issue itself holds scope and acceptance criteria. Put any later clarification or handoff in tracker/PR comments, not agent-to-agent chat. Require the implementer to:

- confirm its worktree starts from the current integration branch (reset/rebase onto it if needed);
- use the `tdd` skill and run focused checks;
- commit its ticket work on its task branch;
- merge the latest integration branch into its task branch before reporting done;
- post its handoff on the task issue; do not merge to the integration branch or open a PR.

When an implementer finishes, have a **parallel reviewers subagent** run the `code-review`, `security-audit`, and `code-quality-review` skills against that task branch, using the current integration branch as the base. Put review discussion on the PR and summarize its outcome on the task issue. Resolve actionable findings in a fresh scoped fix agent and rerun review until clear. Only then use a fresh merger agent to merge the task branch into the integration branch. Verify the merge and update tracker state before dispatching newly unblocked tickets. Reconcile uncertain Git or tracker outcomes before retrying.

## 3. Final review and completion

After all tickets are implemented and merged, have a **reviewer subagent** run `code-review` against the entire integration branch as a final integration review. Have a fresh implementer fix actionable findings in a scoped worktree; merge the fixes and rerun review until clear. Do not report completion until this review is clear and final checks pass; do not merge around unresolved findings or failed checks.

If a draft PR exists, mark it ready for review after final checks. Otherwise, resolve each ticket according to tracker close semantics and report the integration branch. Close the parent spec ticket only when all work is complete, verified, and merged. As part of closing it, remove the `in-progress` label. Clean only confirmed-clean implementer worktrees; retain unresolved work and the worker-side run log.

## Retry and escalation rules

- Retry transient infrastructure failures at most twice after the first attempt. Never blindly retry semantic failures, failed checks, or rejected reviews.
- If an operation's outcome is uncertain, reconcile tracker, Git, worker, and Herdr state before repeating it.
- Stop and preserve state/evidence for auth or permission failures, unresolved state mismatches, exhausted retries, ambiguity, or decisions requiring human judgment.
