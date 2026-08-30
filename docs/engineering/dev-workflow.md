# Pi development workflow skill

`dev-workflow` implements already-planned tracker tickets from issue selection through isolated implementation worktrees, pull/merge requests, review, merge, and cleanup.

It supports:

- Tea-compatible Gitea/Forgejo repositories through `tea`
- GitHub repositories through `gh`
- GitLab repositories through `glab`

The forge is selected from `origin`, or explicitly with `DEV_WORKFLOW_FORGE`.

## Install

From this checkout, install globally for your user:

```bash
pi install /absolute/path/to/ws-developement-workflow
```

Or install it only for the current project:

```bash
pi install -l /absolute/path/to/ws-developement-workflow
```

Restart Pi after installation, or run `/reload` in an existing session. Review the package before installing it: skills can instruct Pi to run commands with your account's permissions.

## When to use it

Use this after the human-led wayfinder, planning, specification, and ticket phases have produced implementation tickets.

The skill does **not** create planning tickets. It only implements tickets that are already labelled:

```text
workflow:ready-for-agent
```

Invoke it with an optional ticket ID or URL:

```text
# Process only ticket 43
/skill:dev-workflow 43

# Process all available tickets in the current repository
/skill:dev-workflow
```

The ID must be a tracker issue/ticket, not a branch name, PR/MR ID, or session ID. With an ID, only that ticket is processed. With no ID, the skill considers all open tickets in the current repository.

## Prerequisites

Before invoking the skill:

1. Run it from a checkout of the target repository.
2. Ensure `origin` points to the correct forge repository.
3. Install and authenticate the matching CLI:
   - Tea/Gitea/Forgejo: `tea`
   - GitHub: `gh`
   - GitLab: `glab`
4. Create implementation tickets, optionally grouped under a root issue.
5. Mark implementable tickets `workflow:ready-for-agent`.
6. Add native child/dependency relationships where supported. Otherwise put explicit issue URLs or the documented blocker marker in the ticket.
7. Configure `DEV_WORKFLOW_HUMAN_REVIEWER` if the agent may assign human review automatically.

Run the read-only preflight manually from the target repository if needed:

```bash
bash /path/to/this-package/skills/forge-cli/scripts/detect-forge.sh
```

Expected output resembles:

```text
forge=gh
remote=https://github.com/acme/project.git
```

## What happens

For the supplied ticket, or all tickets when no ticket is supplied, the skill:

1. Verifies the repository, forge CLI, authentication, default branch, and capabilities.
2. Reads only the supplied ticket; otherwise reads all open tickets in the repository.
3. Selects only open, unassigned, unblocked `workflow:ready-for-agent` tickets.
4. For a supplied ticket, runs only that ticket; with no ticket, runs currently unblocked tickets in parallel, up to three isolated workers. Dependent tickets wait for their blockers.
5. Claims each selected ticket and changes it to `workflow:implementing`, then gives it to one worker in an isolated Git worktree.
6. Runs local checks, pushes the branch, and creates exactly one PR/MR per ticket.
7. Records URLs, status, evidence, blockers, and handoffs in tracker comments.
8. Reviews each PR/MR for correctness/spec and standards, allowing at most three fix rounds.
9. Resolves conflicts through the conflict workflow instead of aborting or guessing.
10. Merges only when review, local checks, CI, target branch, and blocker gates are clean.
11. Closes the integrated ticket, records the merge receipt, and removes the worktree.
12. Re-queries the scoped ticket set after every merge so newly unblocked tickets can run.

Default worker parallelism is three, subject to the available subagent limit.

## Ticket labels

The skill uses one active workflow label per ticket:

```text
workflow:ready-for-agent
workflow:ready-for-human
workflow:implementing
workflow:pr-open
workflow:review
workflow:changes-requested
workflow:conflict
workflow:blocked
workflow:merged
```

Existing `workflow:ready-for-human` tickets are left untouched and reported as human handoffs. Missing requirements, unsafe ambiguity, credentials, product decisions, unavailable CI, and missing permissions stop the workflow instead of being guessed around.

## Forge CLI recipes

After preflight, the shared `forge-cli` skill contains the common rules and automatically selects one recipe:

- `skills/forge-cli/references/tea.md`
- `skills/forge-cli/references/gh.md`
- `skills/forge-cli/references/glab.md`

Other skills can use it too: install this package globally, then instruct them to load the shared `forge-cli` skill instead of duplicating CLI syntax.

## Completion states

The final report includes:

- merged tickets and PR/MR URLs;
- remaining eligible tickets;
- tickets waiting for human review;
- blocked tickets and exact reasons;
- failed checks and review rounds.

`done` means no open implementation or human tickets remain in the selected scope. If only human tickets remain, the result is `waiting-on-human`.

## Development checks

Validate the package with:

```bash
bash tests/test-workflow.sh
```

This checks skill metadata, references, shell syntax, forge detection, and eligibility filtering.
