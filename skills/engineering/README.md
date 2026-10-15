# Engineering Skills

Daily code work.

## User-invoked

- [code-quality-review](code-quality-review/SKILL.md) — Strict maintainability review focused on abstraction quality, file size, and branching complexity.
- [commit-staged](commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [grill-with-docs](grill-with-docs/SKILL.md) — A relentless interview to sharpen a plan or design, which also creates docs (ADR's and glossary) as we go.
- [implement](implement/SKILL.md) — Implement a piece of work based on a spec or set of tickets.
- [implement-isolation](implement-isolation/SKILL.md) — Implement a piece of work based on a spec or set of tickets in isolation.
- [implement-isolation-tmux](implement-isolation-tmux/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [implement-spec](implement-spec/SKILL.md) — Implement the result of /to-spec and /to-tickets in code.
- [implementation-orchestrator](implementation-orchestrator/SKILL.md) — Implements ready-for-agent tracker tickets through isolated worktrees, pull requests, review, conflict resolution, and merge. Use after wayfinder and planning have produced tickets, with or without a ticket ID/URL; no ticket ID/URL means process available tickets. Does not create planning tickets.
- [improve-codebase-architecture](improve-codebase-architecture/SKILL.md) — Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- [orchestrate-herdr](orchestrate-herdr/SKILL.md) — Start a planner from a tracker spec, plan, map, or conversation after validating its tracer-bullet work tickets. Invocation: /skill:orchestrate-herdr ISSUE [WORKER]; omitted worker uses the current local worker.
- [project-context-pack](project-context-pack/SKILL.md) — Create a bounded repository context pack for future agent sessions.
- [recipe-diagrams](recipe-diagrams/SKILL.md) — Turn a recipe into a high-resolution Cooking for Engineers-style process-flow PNG.
- [security-audit](security-audit/SKILL.md) — Audit changed code in a branch or PR for security vulnerabilities, regressions, DevEx breaks, and feature-gate leaks.
- [triage](triage/SKILL.md) — Move issues and external PRs through a state machine of triage roles, categorise, verify, grill if needed, and write agent-ready briefs.
- [wayfinder](wayfinder/SKILL.md) — Plan a huge chunk of work (more than one agent session can hold) as a shared map of decision tickets on your issue tracker, and resolve them one at a time until the way to the destination is clear.
- [feedback-bundle](feedback-bundle/SKILL.md) — File a Gitea feedback issue with commit context and attached logs or screenshots.
- [code-review](code-review/SKILL.md) — Review changes since a fixed point against repository standards and the originating spec, with separate findings for each.
- [codebase-design](codebase-design/SKILL.md) — Shared vocabulary and principles for designing deeper, more testable modules.
- [diagnosing-bugs](diagnosing-bugs/SKILL.md) — Structured diagnosis process for hard bugs and performance regressions.
- [dual-review](dual-review/SKILL.md) — Two independent reviews of a branch diff: correctness/security and maintainability.
- [resolving-merge-conflicts](resolving-merge-conflicts/SKILL.md) — Resolve an in-progress Git merge or rebase conflict.

## Model-invoked

- [domain-modeling](domain-modeling/SKILL.md) — Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a CONTEXT.md, or recording or editing an ADR.
- [forge-cli](forge-cli/SKILL.md) — Provides copy-paste, non-interactive tea, gh, and glab commands for issue and pull or merge request work. Use whenever a task needs tracker inspection, assignment, labels, comments, reviews, CI, or merge operations.
- [pr](pr/SKILL.md) — Use when writing a PR body.
- [prototype](prototype/SKILL.md) — Build a throwaway prototype to test a logic or state model, or explore a UI. Use when a quick runnable artifact can resolve a design question.
- [research](research/SKILL.md) — Delegate primary-source research and save cited findings in a repo Markdown file. Use for topic research, docs or API fact-finding, or reading-heavy investigations.
- [test-first](test-first/SKILL.md) — Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
- [to-spec](to-spec/SKILL.md) — Turn the current conversation into a spec and publish it to the project issue tracker: no interview, just synthesis of what you've already discussed. Use when the user wants a spec from the current conversation or an orchestration workflow needs to publish one from context.
- [to-tickets](to-tickets/SKILL.md) — Break a plan, spec, or the current conversation into tracer-bullet tickets with blocking edges, published to the configured tracker. Use when the user wants tickets from a plan or spec, or an orchestration workflow needs agent-grabbable tickets.
- [wizard](wizard/SKILL.md) — Create interactive Bash wizards for human-only setup or cutovers. Use for provisioning, credentials or CI secrets, unfamiliar dashboards, or one-off migrations—not tasks the agent can do.
- [worktrees](worktrees/SKILL.md) — Manage Git worktrees in a canonical `.bare` repository root. Use when creating, reusing, listing, removing, or repairing worktrees, or when setting up a repository to keep all branch checkouts under one root.
- [write-discoverable-code](write-discoverable-code/SKILL.md) — Name and place code so a plain-text search finds it in one hit. Use when writing or renaming functions, types, constants, files, error messages, or doc comments, including ordinary implementation with no mention of search or discoverability. Not for style, architecture, or type-system design.
