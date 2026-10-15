# Skills

Agent skills (slash commands and behaviors) loaded into AI coding agents.

Skills are grouped by invocation type. [User-invoked](docs/invocation.md) skills run only when a person invokes them; model-invoked skills can also be selected automatically.

## Credits

Many of these skills were created or originated by the following people and organizations:

- [Matt Pocock](http://mattpocock.com)
- [poteto](https://github.com/poteto?tab=repositories)

## User-invoked

### Setup

- [setup-skills](skills/setup-skills/SKILL.md) — Configure this repo for the engineering skills, set up its issue tracker, triage label vocabulary, and domain doc layout. Run once before first use of the other engineering skills.

### Engineering

- [code-quality-review](skills/engineering/code-quality-review/SKILL.md) — Strict maintainability review focused on abstraction quality, file size, and branching complexity.
- [commit-staged](skills/engineering/commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [grill-with-docs](skills/engineering/grill-with-docs/SKILL.md) — A relentless interview to sharpen a plan or design, which also creates docs (ADR's and glossary) as we go.
- [implement](skills/engineering/implement/SKILL.md) — Implement a piece of work based on a spec or set of tickets.
- [implement-isolation](skills/engineering/implement-isolation/SKILL.md) — Implement a piece of work based on a spec or set of tickets in isolation.
- [implement-isolation-tmux](skills/engineering/implement-isolation-tmux/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [implement-spec](skills/engineering/implement-spec/SKILL.md) — Implement the result of /to-spec and /to-tickets in code.
- [implementation-orchestrator](skills/engineering/implementation-orchestrator/SKILL.md) — Implements ready-for-agent tracker tickets through isolated worktrees, pull requests, review, conflict resolution, and merge. Use after wayfinder and planning have produced tickets, with or without a ticket ID/URL; no ticket ID/URL means process available tickets. Does not create planning tickets.
- [improve-codebase-architecture](skills/engineering/improve-codebase-architecture/SKILL.md) — Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- [orchestrate-herdr](skills/engineering/orchestrate-herdr/SKILL.md) — Start a planner from a tracker spec, plan, map, or conversation after validating its tracer-bullet work tickets. Invocation: /skill:orchestrate-herdr ISSUE [WORKER]; omitted worker uses the current local worker.
- [project-context-pack](skills/engineering/project-context-pack/SKILL.md) — Create a bounded repository context pack for future agent sessions.
- [recipe-diagrams](skills/engineering/recipe-diagrams/SKILL.md) — Turn a recipe into a high-resolution Cooking for Engineers-style process-flow PNG.
- [security-audit](skills/engineering/security-audit/SKILL.md) — Audit changed code in a branch or PR for security vulnerabilities, regressions, DevEx breaks, and feature-gate leaks.
- [triage](skills/engineering/triage/SKILL.md) — Move issues and external PRs through a state machine of triage roles, categorise, verify, grill if needed, and write agent-ready briefs.
- [wayfinder](skills/engineering/wayfinder/SKILL.md) — Plan a huge chunk of work (more than one agent session can hold) as a shared map of decision tickets on your issue tracker, and resolve them one at a time until the way to the destination is clear.
- [feedback-bundle](skills/engineering/feedback-bundle/SKILL.md) — File a Gitea feedback issue with commit context and attached logs or screenshots.
- [code-review](skills/engineering/code-review/SKILL.md) — Review changes since a fixed point against repository standards and the originating spec, with separate findings for each.
- [codebase-design](skills/engineering/codebase-design/SKILL.md) — Shared vocabulary and principles for designing deeper, more testable modules.
- [diagnosing-bugs](skills/engineering/diagnosing-bugs/SKILL.md) — Structured diagnosis process for hard bugs and performance regressions.
- [dual-review](skills/engineering/dual-review/SKILL.md) — Two independent reviews of a branch diff: correctness/security and maintainability.
- [resolving-merge-conflicts](skills/engineering/resolving-merge-conflicts/SKILL.md) — Resolve an in-progress Git merge or rebase conflict.

### In Progress

- [agent-handoff](skills/in-progress/agent-handoff/SKILL.md) — Hand the current conversation off to a fresh background agent that picks up the work immediately.
- [knowledge-gardener](skills/in-progress/knowledge-gardener/SKILL.md) — Run vault-aware semantic search, synthesis, note creation, linking, and Zettelkasten workflows for this Obsidian vault.

### Misc

- [code-rationale](skills/misc/code-rationale/SKILL.md) — Investigate code motivation using cited historical evidence and calibrated confidence.
- [show-me](skills/misc/show-me/SKILL.md) — Help the user understand the current topic visually with concise diagrams, code-shape sketches, and focused HTML artifacts.
- [tmux-launch-agent](skills/misc/tmux-launch-agent/SKILL.md) — Fork a new agent CLI session into a new tmux window, detected from the current agent.
- [visual-verification](skills/misc/visual-verification/SKILL.md) — Verify desktop UI changes using screenshots and recordings.
- [migrate-to-shoehorn](skills/misc/migrate-to-shoehorn/SKILL.md) — Migrate test files from TypeScript assertions to @total-typescript/shoehorn.
- [scaffold-exercises](skills/misc/scaffold-exercises/SKILL.md) — Scaffold lint-passing exercise directories with sections, problems, solutions, and explainers.
- [setup-pre-commit](skills/misc/setup-pre-commit/SKILL.md) — Set up Husky pre-commit hooks with lint-staged formatting, type checking, and tests.

### Personal

- [arch-maintenance](skills/personal/arch-maintenance/SKILL.md) — Keep an Arch or CachyOS system updated and healthy with status, check, and update workflows.
- [arch-troubleshooting](skills/personal/arch-troubleshooting/SKILL.md) — Diagnose and repair Arch or CachyOS system problems.

### Pkm

- [conversation-summary](skills/pkm/conversation-summary/SKILL.md) — Save the current conversation as a comprehensive report note in your Obsidian vault, following OKF v0.1 conventions.
- [crit](skills/pkm/crit/SKILL.md) — Run the CRIT framework — give the AI Context, assign it a Role, let it Interview you one question at a time, then issue the Task.
- [research-vault](skills/pkm/research-vault/SKILL.md) — Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked OKF-conformant research packet in the Obsidian vault.
- [youtube-video-capture](skills/pkm/youtube-video-capture/SKILL.md) — Save a YouTube video's summary and raw subtitles into the vault's Video bundle.
- [pkm-curation](skills/pkm/pkm-curation/SKILL.md) — Curate an Obsidian vault by classifying notes, normalizing frontmatter, linking related notes, and extracting atomic notes.

### Productivity

- [grill-me](skills/productivity/grill-me/SKILL.md) — A relentless interview to sharpen a plan or design.
- [handoff](skills/productivity/handoff/SKILL.md) — Compact the current conversation into a handoff document for another agent to pick up.
- [to-questionnaire](skills/productivity/to-questionnaire/SKILL.md) — Turn a decision you can't fully answer into a questionnaire for someone else to fill in.
- [wait-what](skills/productivity/wait-what/SKILL.md) — Stop. That last message did not land: re-pitch it.
- [writing-for-agents](skills/productivity/writing-for-agents/SKILL.md) — Write and maintain agent-facing skills, instructions, and documentation.

### Skill Authoring

- [effective-agent-skills](skills/skill-authoring/effective-agent-skills/SKILL.md) — Reference for designing, authoring, testing, and securing agent skills.

### Thinking And Docs

- [before-building](skills/thinking-and-docs/before-building/SKILL.md) — Fire the moment the user proposes a build. Instantly surface the 1-3 consequential choices hidden in his idea. Can also be invoked with /before-building.
- [decisions](skills/thinking-and-docs/decisions/SKILL.md) — Ask the agent to list all choices it made during the current work that it is not confident of. Manual-only; invoke with /decisions.
- [level-up](skills/thinking-and-docs/level-up/SKILL.md) — Assess technical and product knowledge, record ratings, and create a learning plan.
- [read-all-adrs](skills/thinking-and-docs/read-all-adrs/SKILL.md) — Read every ADR in the project's docs/adr directory.
- [remind](skills/thinking-and-docs/remind/SKILL.md) — Rewrite the last response simpler and shorter in plain English, prefixed with a 3-5 sentence TLDR of the conversation so far. Manual-only, invoked as /remind.
- [short](skills/thinking-and-docs/short/SKILL.md) — Shorten the current answer while preserving its substance.
- [learning-coach](skills/thinking-and-docs/learning-coach/SKILL.md) — Teach the user a new skill or concept, within this workspace.
- [brain-to-docs](skills/thinking-and-docs/brain-to-docs/SKILL.md) — Extract project vision, decisions, and preferences into a README and ADRs through a Q&A process.
- [next-decision](skills/thinking-and-docs/next-decision/SKILL.md) — Resolve open decisions one at a time with options and a recommendation.
- [prompt-me](skills/thinking-and-docs/prompt-me/SKILL.md) — Elicit a project's priorities and open concerns through focused questions.
- [save-idea](skills/thinking-and-docs/save-idea/SKILL.md) — Capture content ideas in the user's video or podcast topic backlog.

## Model-invoked

### Engineering

- [domain-modeling](skills/engineering/domain-modeling/SKILL.md) — Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a CONTEXT.md, or recording or editing an ADR.
- [forge-cli](skills/engineering/forge-cli/SKILL.md) — Provides copy-paste, non-interactive tea, gh, and glab commands for issue and pull or merge request work. Use whenever a task needs tracker inspection, assignment, labels, comments, reviews, CI, or merge operations.
- [pr](skills/engineering/pr/SKILL.md) — Use when writing a PR body.
- [prototype](skills/engineering/prototype/SKILL.md) — Build a throwaway prototype to test a logic or state model, or explore a UI. Use when a quick runnable artifact can resolve a design question.
- [research](skills/engineering/research/SKILL.md) — Delegate primary-source research and save cited findings in a repo Markdown file. Use for topic research, docs or API fact-finding, or reading-heavy investigations.
- [test-first](skills/engineering/test-first/SKILL.md) — Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
- [to-spec](skills/engineering/to-spec/SKILL.md) — Turn the current conversation into a spec and publish it to the project issue tracker: no interview, just synthesis of what you've already discussed. Use when the user wants a spec from the current conversation or an orchestration workflow needs to publish one from context.
- [to-tickets](skills/engineering/to-tickets/SKILL.md) — Break a plan, spec, or the current conversation into tracer-bullet tickets with blocking edges, published to the configured tracker. Use when the user wants tickets from a plan or spec, or an orchestration workflow needs agent-grabbable tickets.
- [wizard](skills/engineering/wizard/SKILL.md) — Create interactive Bash wizards for human-only setup or cutovers. Use for provisioning, credentials or CI secrets, unfamiliar dashboards, or one-off migrations—not tasks the agent can do.
- [worktrees](skills/engineering/worktrees/SKILL.md) — Manage Git worktrees in a canonical `.bare` repository root. Use when creating, reusing, listing, removing, or repairing worktrees, or when setting up a repository to keep all branch checkouts under one root.
- [write-discoverable-code](skills/engineering/write-discoverable-code/SKILL.md) — Name and place code so a plain-text search finds it in one hit. Use when writing or renaming functions, types, constants, files, error messages, or doc comments, including ordinary implementation with no mention of search or discoverability. Not for style, architecture, or type-system design.

### Productivity

- [grilling](skills/productivity/grilling/SKILL.md) — Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
