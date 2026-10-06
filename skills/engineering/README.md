# Engineering Skills

Daily code work.

## User-invoked

- [thermo-nuclear-code-quality-review](code-quality-review/SKILL.md) — Run an extremely strict maintainability review for abstraction quality, giant files, and spaghetti-condition growth. Use for a thermo-nuclear code quality review, thermonuclear review, deep code quality audit, or especially harsh maintainability review.
- [commit-staged](commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [grill-with-docs](grill-with-docs/SKILL.md) — A relentless interview to sharpen a plan or design, which also creates docs (ADR's and glossary) as we go.
- [implement](implement/SKILL.md) — Implement a piece of work based on a spec or set of tickets.
- [implement-isolation](implement-isolation/SKILL.md) — Implement a piece of work based on a spec or set of tickets in isolation.
- [implement-isolation-tmux](implement-isolation-tmux/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [implement-spec](implement-spec/SKILL.md) — Implement the result of /to-spec and /to-tickets in code.
- [implementation-orchestrator](implementation-orchestrator/SKILL.md) — Implements ready-for-agent tracker tickets through isolated worktrees, pull requests, review, conflict resolution, and merge. Use after wayfinder and planning have produced tickets, with or without a ticket ID/URL; no ticket ID/URL means process available tickets. Does not create planning tickets.
- [improve-codebase-architecture](improve-codebase-architecture/SKILL.md) — Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- [orchestrate-herdr](orchestrate-herdr/SKILL.md) — Implement a published spec ticket using Herdr and Pi agents on a named worker node.
- [project-context-pack](project-context-pack/SKILL.md) — Use when the user wants a bounded repo context pack, project map, codebase index, or cached memory file so later work uses fd/rg/tree-sitter/LSP instead of repeated browsing.
- [recipe-diagrams](recipe-diagrams/SKILL.md) — Recipe diagrams: convert any recipe into a high-resolution Cooking for Engineers-style PNG process-flow table with aligned ingredient streams, preparation branches, joins, temperatures, timings, and finish steps. Use when the user asks for a recipe diagram.
- [security-audit](security-audit/SKILL.md) — Comprehensive security and correctness audit of a branch's changes. Use for deep review requests, or branch/PR diff audits focused on bugs, breaking changes, security issues, devex regressions, and feature-gate leaks.
- [triage](triage/SKILL.md) — Move issues and external PRs through a state machine of triage roles, categorise, verify, grill if needed, and write agent-ready briefs.
- [wayfinder](wayfinder/SKILL.md) — Plan a huge chunk of work (more than one agent session can hold) as a shared map of decision tickets on your issue tracker, and resolve them one at a time until the way to the destination is clear.

## Model-invoked

- [feedback-bundle](feedback-bundle/SKILL.md) — Post a Gitea feedback issue linked to the current commit and attach logs or screenshots. Use when the user reports a problem and asks to file it with evidence, open a bug ticket, or says “feedback-bundle” or “attach the log.”
- [code-review](code-review/SKILL.md) — Review the changes since a fixed point (commit, branch, tag, or merge-base) along two axes: Standards (does the code follow this repo's documented coding standards?) and Spec (does the code match what the originating issue/spec asked for?). Runs both reviews in parallel sub-agents and reports them side by side. Use when the user wants to review a branch, a PR, work-in-progress changes, or asks to "review since X".
- [codebase-design](codebase-design/SKILL.md) — Shared vocabulary for designing deep modules. Use when the user wants to design or improve a module's interface, find deepening opportunities, decide where a seam goes, make code more testable or AI-navigable, or when another skill needs the deep-module vocabulary.
- [diagnosing-bugs](diagnosing-bugs/SKILL.md) — Diagnosis loop for hard bugs and performance regressions. Use when the user says "diagnose"/"debug this", or reports something broken/throwing/failing/slow.
- [domain-modeling](domain-modeling/SKILL.md) — Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a CONTEXT.md, or recording or editing an ADR.
- [dual-review](dual-review/SKILL.md) — Run two independent, read-only reviews of a branch diff in parallel — correctness/security and maintainability — then synthesize prioritized findings. Use for a second review axis alongside code-review, a combined deep plus code-quality audit, or when the user asks for dual review. Runs both axes as parallel sub-agents so they do not pollute each other's context.
- [forge-cli](forge-cli/SKILL.md) — Provides copy-paste, non-interactive tea, gh, and glab commands for issue and pull or merge request work. Use whenever a task needs tracker inspection, assignment, labels, comments, reviews, CI, or merge operations.
- [lsp-code-analysis](lsp-code-analysis/SKILL.md) — Semantic code analysis via LSP. Navigate code (definitions, references, implementations), search symbols, preview refactorings, and get file outlines. Use for exploring unfamiliar codebases or performing safe refactoring.
- [pr](pr/SKILL.md) — Use when writing a PR body.
- [prototype](prototype/SKILL.md) — Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check whether a state model or logic feels right, or explore what a UI should look like.
- [research](research/SKILL.md) — Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
- [resolving-merge-conflicts](resolving-merge-conflicts/SKILL.md) — Use when you need to resolve an in-progress git merge/rebase conflict.
- [tdd](tdd/SKILL.md) — Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
- [to-spec](to-spec/SKILL.md) — Turn the current conversation into a spec and publish it to the project issue tracker: no interview, just synthesis of what you've already discussed. Use when the user wants a spec from the current conversation or an orchestration workflow needs to publish one from context.
- [to-tickets](to-tickets/SKILL.md) — Break a plan, spec, or the current conversation into tracer-bullet tickets with blocking edges, published to the configured tracker. Use when the user wants tickets from a plan or spec, or an orchestration workflow needs agent-grabbable tickets.
- [wizard](wizard/SKILL.md) — Generate an interactive bash wizard that walks a human through steps only they can perform. Use when provisioning infrastructure, setting up credentials or CI secrets, walking an unfamiliar third-party dashboard, or running a one-off migration or cutover. Don't invoke this for steps the agent can perform itself.
- [worktrees](worktrees/SKILL.md) — Manage Git worktrees in a canonical `.bare` repository root. Use when creating, reusing, listing, removing, or repairing worktrees, or when setting up a repository to keep all branch checkouts under one root.
- [write-discoverable-code](write-discoverable-code/SKILL.md) — |
