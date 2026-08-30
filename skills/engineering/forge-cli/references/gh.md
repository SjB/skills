# GitHub CLI recipe

Use `gh` commands in the current repository. Use `--json` for reads and `--body-file` for multiline bodies.

## Read

```bash
gh issue view ID --comments --json number,state,url,title,body,assignees,labels,comments,parent,subIssues,blockedBy
gh issue list --state all --limit 100 --json number,state,url,title,body,assignees,labels,parent,subIssues,blockedBy
gh pr view PR --comments --json number,state,url,title,body,assignees,labels,baseRefName,headRefName,comments,reviews,reviewDecision,statusCheckRollup,mergeable
gh pr checks PR --required --json bucket,name,state,completedAt
```

If an installed version rejects an optional JSON field, remove that field and rerun the same read. Native parent, child, and dependency fields may be unavailable; otherwise use the explicit links documented in the ticket.

## Issue lifecycle

```bash
gh issue edit ID --add-assignee USER
gh issue edit ID --add-label NEW --remove-label OLD
gh issue comment ID --body-file BODY_FILE
gh issue close ID
```

`@me` means the current authenticated user.

## Pull request lifecycle

```bash
gh pr create --base BASE --head HEAD --title TITLE --body-file BODY_FILE
gh pr comment PR --body-file BODY_FILE
gh pr review PR --comment --body-file BODY_FILE
gh pr review PR --request-changes --body-file BODY_FILE
gh pr merge PR --squash --delete-branch
```

Re-read the issue/PR after every mutation. Do not use `--admin` or `--auto`.
