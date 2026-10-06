# Run loop: implement a spec ticket

The spec and its linked tickets define scope; the tracker is source of truth. Begin by reading the spec ticket, every associated ticket, blockers, and relevant comments. If the spec has no linked implementation tickets forming an actionable frontier, invoke `/to-tickets` and follow its approval and publishing process before implementation. If existing tickets are blocked, don't invent additional work.

The issue tracker should have been provided to you. If not, tell the user to run `/setup-skills`.

The goal is the entire spec implemented on a single **integration branch**, with every ticket resolved the way the issue tracker closes work.

The tickets are not a list of steps. They are a **task graph** with blocking relationships between them. This means there is always a **frontier** of tickets which are ready to be grabbed.

Communication to and from subagents should be sparse. Communicate primarily through **context pointers**: to the spec, tickets, research notes, and previous commits. Don't duplicate information already available via pointers.

## 1. Read and establish the integration branch

- Confirm the supplied ticket is the spec/parent ticket and identify its linked implementation tickets.
- Understand the ticket graph and its current frontier. Re-query tracker state as work advances.
- When tickets require codebase or external-documentation exploration, dispatch an exploration subagent before implementation. Have it save concise Markdown notes outside the repo in a directory accessible to all future subagents; pass those notes as context pointers to implementers.
- Create one integration branch from the intended target branch. If a PR is required, open a draft after the first implementation merge and link it to close the spec and tickets.
- If a ticket or its dependencies are ambiguous, stop and ask rather than inferring.

## 2. Implement the frontier

For each open, unblocked ticket, start a **new implementer subagents** in its own worktree and branch. Independent frontier tickets may run concurrently; never parallel-write a shared checkout. Start a fresh merger agent for each merge as well.

Each implementer gets the full ticket and acceptance criteria, relevant context pointers, scope boundaries, worktree path, and starting branch. Require the implementer to:

- confirm its worktree starts from the current integration branch (reset/rebase onto it if needed);
- use the `tdd` skill and run focused checks;
- commit its ticket work on its task branch;
- merge the latest integration branch into its task branch before reporting done;
- report changed files, commit, checks, and any blockers; do not merge to the integration branch or open a PR.

When an implementer finishes, have a **new independent reviewer agent** run the `code-review` skill against that task branch, using the current integration branch as the base. Resolve all actionable findings in a fresh scoped fix agent and rerun the review until clear. Only then use a fresh merger agent to merge the task branch into the integration branch. Verify the merge and update tracker state before dispatching newly unblocked tickets. Reconcile uncertain Git or tracker outcomes before retrying.

## 3. Final review and completion

After all tickets are implemented and merged, run `code-review` against the entire integration branch as a final integration review. Have a fresh implementer fix all actionable findings in a scoped worktree; merge the fixes and rerun review until clear. Do not report completion until this review is clear and final checks pass; do not merge around unresolved findings or failed checks.

If a draft PR exists, mark it ready for review after final checks. Otherwise, resolve each ticket according to the tracker's close semantics and report the integration branch. Close the parent spec ticket only when all work is complete, verified, and merged. Clean up implementer worktrees only after confirming they are clean; retain unresolved work.

## Retry and escalation rules

- Retry transient infrastructure failures at most twice after the first attempt. Never blindly retry semantic failures, failed checks, or rejected reviews.
- If an operation's outcome is uncertain, reconcile tracker, Git, worker, and Herdr state before repeating it.
- Stop and preserve state/evidence for auth or permission failures, unresolved state mismatches, exhausted retries, ambiguity, or decisions requiring human judgment.
