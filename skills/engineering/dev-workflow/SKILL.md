---
name: dev-workflow
description: Implements ready-for-agent tracker tickets through isolated worktrees, pull requests, review, conflict resolution, and merge. Use after wayfinder and planning have produced tickets, when the user gives a ticket ID, asks to process available tickets, or asks to run the development workflow. Does not create planning tickets.
disable-model-invocation: true
---

# Development workflow

Use this skill only after the human-led wayfinder, plan, spec, and ticket phases. The optional argument is a **tracker ticket ID or URL**. With an argument, process only that ticket. With no argument, scope the run to all open tickets in the current repository. An ID means the forge's issue/ticket identifier, not a branch, session, or PR ID.

## Compose before acting

Read and use these skills for their specialized work:

- `pi-subagents` for parallel workers and managed worktrees
- `worktrees` for worktree conventions and cleanup
- `code-review` for independent correctness/spec and standards review
- `resolving-merge-conflicts` for conflicts; never abort a merge or rebase
- `forge-cli` for forge selection, authentication, and CLI recipes

Load the shared `forge-cli` skill and run its bundled read-only preflight with the target repository as the working directory. Read only the detected CLI recipe; copy those commands instead of rediscovering syntax. Run `<cli> <command> --help` only when a recipe fails with an unknown command or flag. Do not add an API client or dependency.

## Durable state

The tracker is the source of truth. Read the root, every candidate ticket, and their existing comments before acting. Use one active label per ticket:

- `workflow:ready-for-agent`
- `workflow:ready-for-human`
- `workflow:implementing`
- `workflow:pr-open`
- `workflow:review`
- `workflow:changes-requested`
- `workflow:conflict`
- `workflow:blocked`
- `workflow:merged`

Comments are the message board. Record claims, status, evidence, questions, decisions, handoffs, PR URLs, check results, and recovery details there. If a worker has an issue with a ticket, comment on the ticket and wait for the human or another agent rather than guessing. For PR/MR issues, use the PR/MR's native comment/review function and also link the discussion from the ticket. Use `DEV_WORKFLOW_HUMAN_REVIEWER` or repository workflow configuration for the human identity; if none is configured, ask before assigning and do not invent an identity.

## Run loop

1. **Scope.** If a ticket ID/URL is supplied, confirm it belongs to the current repository and inspect only that ticket; do not process its siblings, parent, or descendants. If omitted, query all open tickets in the current repository. Use native child/dependency relationships; otherwise require explicit linked URLs or the documented blocker marker. Never infer order from titles.
2. **Schedule.** Eligible means open, unassigned, unblocked, and labelled `workflow:ready-for-agent`. Already `workflow:ready-for-human` tickets are skipped and reported. For a supplied ticket, process only that ticket; if it is blocked, report it and do not process its blockers. With no supplied ticket, build the dependency frontier: launch currently unblocked tickets in parallel, up to three workers, and hold dependent tickets until every blocker is merged or otherwise resolved. Re-query after each merge and launch newly unblocked tickets; dependency chains therefore run sequentially while unrelated tickets remain parallel.
3. **Claim.** Assign each selected ticket to the current forge identity before work. Replace its state with `workflow:implementing` and comment the claim.
4. **Implement.** Launch one worker per ticket with `pi-subagents` in an isolated worktree, maximum three in flight by default. Pass the complete ticket, comments, acceptance criteria, non-goals, linked context, and validation contract. Each worker makes only ticket-scoped changes, commits them, and reports changed files and checks.
5. **Escalate.** For missing requirements, unsafe ambiguity, credentials, unrelated scope, or a product/architecture decision, stop. For human review or judgment, assign the ticket to the configured human reviewer, apply `workflow:ready-for-human`, and comment the exact request. If no human identity is configured, ask before assigning and changing the state. Use `workflow:blocked` for non-human blockers. Preserve the worktree on failure.
6. **PR.** Run documented local checks. Push the branch and create exactly one PR/MR for the ticket. Link the ticket's tracker ID and title in the PR/MR, set `workflow:pr-open`, and comment the PR/MR URL on the ticket. Keep the worktree.
7. **Review.** Set `workflow:review`. Run a fresh-context `code-review` review with correctness/spec and standards axes separate. Post findings through the PR/MR comment/review function. For actionable findings, set `workflow:changes-requested`, send one fix worker, rerun checks, and repeat. Allow at most three rounds.
8. **Conflict.** Set `workflow:conflict`, then follow `resolving-merge-conflicts`. Inspect both intents, preserve them where possible, never invent behavior, never abort, rerun local checks, and update the PR/MR. If judgment is needed, assign the PR/MR and ticket to the configured human reviewer, apply `workflow:ready-for-human`, and comment the request in both places. If no human identity is configured, ask before assigning.
9. **Merge.** Merge only after independent review is clean, local checks pass, forge CI is green, the target is still the expected default branch, and no human decision or blocker remains. Comment the merge receipt and outcome, close the ticket, apply `workflow:merged` when supported, verify integration, then remove the worktree.
10. **Finish.** Report merged tickets and PR/MR URLs, human handoffs, blocked tickets, failed checks, review rounds, and remaining eligible tickets. Report `done` only when no open implementation or human tickets remain in the selected scope. If only human tickets remain, report `waiting-on-human`.

Never parallel-write a shared checkout. Never silently relabel an existing human ticket. Never merge around a failed check, unresolved review finding, conflict, or missing decision.
