# Engineering Skills

Daily code work.

## User-invoked

- [code-quality-review](code-quality-review/SKILL.md) — Strict maintainability review focused on abstraction quality, file size, and branching complexity.
- [commit-staged](commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [grill-with-docs](grill-with-docs/SKILL.md) — A relentless interview to sharpen a plan or design, which also creates docs (ADR's and glossary) as we go.
- [implement](implement/SKILL.md) — Implement work from a spec or tickets.
- [implement-isolation](implement-isolation/SKILL.md) — Implement a piece of work based on a spec or set of tickets in isolation.
- [implement-isolation-tmux](implement-isolation-tmux/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [implement-spec](implement-spec/SKILL.md) — Implement the result of /to-spec and /to-tickets in code.
- [implementation-orchestrator](implementation-orchestrator/SKILL.md) — Implements ready-for-agent tracker tickets through isolated worktrees, pull requests, review, conflict resolution, and merge. Use after wayfinder and planning have produced tickets, with or without a ticket ID/URL; no ticket ID/URL means process available tickets. Does not create planning tickets.
- [improve-codebase-architecture](improve-codebase-architecture/SKILL.md) — Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- [orchestrate-herdr](orchestrate-herdr/SKILL.md) — Start a planner from a tracker spec, plan, map, or conversation after validating its tracer-bullet work tickets. Invocation: /skill:orchestrate-herdr ISSUE [WORKER]; omitted worker uses the current local worker.
- [project-context-pack](project-context-pack/SKILL.md) — Create a bounded repository context pack for future agent sessions.
- [recipe-diagrams](recipe-diagrams/SKILL.md) — Turn a recipe into a high-resolution Cooking for Engineers-style process-flow PNG.
- [security-audit](security-audit/SKILL.md) — Audit changed code in a branch or PR for security vulnerabilities, regressions, and feature-gate leaks.
- [triage](triage/SKILL.md) — Move issues and external PRs through a state machine of triage roles, categorise, verify, grill if needed, and write agent-ready briefs.
- [wayfinder](wayfinder/SKILL.md) — Plan a huge chunk of work (more than one agent session can hold) as a shared map of decision tickets on your issue tracker, and resolve them one at a time until the way to the destination is clear.
- [feedback-bundle](feedback-bundle/SKILL.md) — File a Gitea feedback issue with commit context and attached logs or screenshots.
- [code-review](code-review/SKILL.md) — Review changes since a fixed point against repository standards and the originating spec, with separate findings for each.
- [codebase-design](codebase-design/SKILL.md) — Shared vocabulary and principles for designing deeper, more testable modules.
- [diagnosing-bugs](diagnosing-bugs/SKILL.md) — Structured diagnosis process for hard bugs and performance regressions.
- [dual-review](dual-review/SKILL.md) — Two independent reviews of a branch diff; correctness/security and maintainability.
- [resolving-merge-conflicts](resolving-merge-conflicts/SKILL.md) — Resolve an in-progress Git merge or rebase conflict.

## Model-invoked

- [domain-modeling](domain-modeling/SKILL.md) — Build a project's domain model. Use when shaping terminology or creating or editing `CONTEXT.md` or ADRs.
- [forge-cli](forge-cli/SKILL.md) — Non-interactive `tea`, `gh`, and `glab` commands for tracker work. Use for issues, assignment, labels, comments, reviews, CI, or merges.
- [pr](pr/SKILL.md) — Use when writing a PR body.
- [prototype](prototype/SKILL.md) — Build a throwaway prototype for logic or state models, or UI. Use when a runnable example can clarify behavior or design.
- [research](research/SKILL.md) — Delegate primary-source research and save cited findings in a repo Markdown file. Use for topic research, docs, APIs, specs, or reading-heavy investigations.
- [test-first](test-first/SKILL.md) — Use TDD for features or bug fixes. Trigger on “test-first,” “red-green-refactor,” or integration-test requests.
- [to-spec](to-spec/SKILL.md) — Synthesize the current conversation into a spec and publish it to the issue tracker—no interview. Use when asked for a spec or when orchestration needs one.
- [to-tickets](to-tickets/SKILL.md) — Break a plan, spec, or conversation into tracer-bullet tickets with blocking edges, then publish to the configured tracker. Use when asked to create tickets or make work agent-ready.
- [wizard](wizard/SKILL.md) — Create interactive Bash wizards for human-only setup or cutovers. Use for provisioning credentials or CI secrets, unfamiliar dashboards, or one-off migrations—not tasks the agent can do.
- [worktrees](worktrees/SKILL.md) — Manage Git worktrees under a canonical `.bare` root. Use to create, reuse, list, remove, or repair worktrees, or set up a repo for them.
- [write-discoverable-code](write-discoverable-code/SKILL.md) — Name and place code for one-hit plain-text search. Use when writing or renaming functions, types, constants, files, errors, or docs, including routine implementation. Not for style, architecture, or type design.
