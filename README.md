# Skills

Agent skills (slash commands and behaviors) loaded into AI coding agents.

Skills are grouped by invocation type. [User-invoked](docs/invocation.md) skills run only when a person invokes them; model-invoked skills can also be selected automatically.

## User-invoked

### Engineering

- [commit-staged](skills/engineering/commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [grill-with-docs](skills/engineering/grill-with-docs/SKILL.md) — Interview the user to sharpen a plan or design while creating ADRs and glossary docs.
- [implement](skills/engineering/implement/SKILL.md) — Implement a piece of work from a spec or set of tickets.
- [implement-isolation](skills/engineering/implement-isolation/SKILL.md) — Implement a piece of work from a spec or set of tickets in isolation.
- [implement-isolation-tmux](skills/engineering/implement-isolation-tmux/SKILL.md) — Dispatch an isolated worktree agent to implement work from a PRD or issues.
- [improve-codebase-architecture](skills/engineering/improve-codebase-architecture/SKILL.md) — Find and work through opportunities to deepen a codebase's architecture.
- [project-context-pack](skills/engineering/project-context-pack/SKILL.md) — Build a bounded project context pack for later agent work.
- [setup-skills](skills/setup-skills/SKILL.md) — Configure engineering skills, issue tracking, triage labels, and domain docs.
- [to-spec](skills/engineering/to-spec/SKILL.md) — Turn the current conversation into a spec and publish it to the issue tracker.
- [to-tickets](skills/engineering/to-tickets/SKILL.md) — Break a plan or spec into tracer-bullet tickets with dependencies.
- [triage](skills/engineering/triage/SKILL.md) — Triage issues and external PRs through the project workflow.
- [wayfinder](skills/engineering/wayfinder/SKILL.md) — Plan large work as decision tickets and resolve them step by step.

### In-progress

- [agent-handoff](skills/in-progress/agent-handoff/SKILL.md) — Hand the current conversation to a fresh background agent.
- [knowledge-gardener](skills/in-progress/knowledge-gardener/SKILL.md) — Run vault-aware search, synthesis, note creation, and linking workflows.

### Miscellaneous

- [bro](skills/misc/bro/SKILL.md) — Restate the last message in plain human language.
- [tmux-launch-agent](skills/misc/tmux-launch-agent/SKILL.md) — Fork a new agent CLI session into a new tmux window.

### PKM

- [conversation-summary](skills/pkm/conversation-summary/SKILL.md) — Save the current conversation as a report note in an Obsidian vault.
- [crit](skills/pkm/crit/SKILL.md) — Run the CRIT framework through context, role, interview, and task.
- [research-vault](skills/pkm/research-vault/SKILL.md) — Research a topic through a guided conversation and save a linked vault packet.
- [youtube-video-capture](skills/pkm/youtube-video-capture/SKILL.md) — Capture a YouTube video's subtitles and summary in an Obsidian vault.

### Productivity

- [grill-me](skills/productivity/grill-me/SKILL.md) — Interview the user to sharpen a plan or design.
- [handoff](skills/productivity/handoff/SKILL.md) — Compact the current conversation into a handoff document.
- [teach](skills/productivity/teach/SKILL.md) — Teach the user a new skill or concept within the workspace.
- [to-questionnaire](skills/productivity/to-questionnaire/SKILL.md) — Turn an unresolved decision into a questionnaire.
- [wait-what](skills/productivity/wait-what/SKILL.md) — Re-pitch the last message in clearer terms.

### Skill authoring

No user-invoked skills.

### Thinking and docs

- [before-building](skills/thinking-and-docs/before-building/SKILL.md) — Surface consequential choices when the user proposes a build.
- [decisions](skills/thinking-and-docs/decisions/SKILL.md) — List choices made during the current work that remain uncertain.
- [level-up](skills/thinking-and-docs/level-up/SKILL.md) — Assess technical and product knowledge and grow a learning plan.
- [read-all-adrs](skills/thinking-and-docs/read-all-adrs/SKILL.md) — Read every ADR in the project's `docs/adr/` folder.
- [remind](skills/thinking-and-docs/remind/SKILL.md) — Rewrite the last response more simply and briefly.
- [short](skills/thinking-and-docs/short/SKILL.md) — Compress the current answer while keeping its substance.
- [teach](skills/thinking-and-docs/teach/SKILL.md) — Teach the user a new skill or concept within the workspace.

## Model-invoked

### Engineering

- [code-review](skills/engineering/code-review/SKILL.md) — Review changes against repository standards and the originating specification.
- [codebase-design](skills/engineering/codebase-design/SKILL.md) — Design and improve deep module interfaces and seams.
- [diagnosing-bugs](skills/engineering/diagnosing-bugs/SKILL.md) — Diagnose hard bugs and performance regressions.
- [domain-modeling](skills/engineering/domain-modeling/SKILL.md) — Build and sharpen a project's domain model.
- [lsp-code-analysis](skills/engineering/lsp-code-analysis/SKILL.md) — Navigate code and analyze it semantically with LSP.
- [prototype](skills/engineering/prototype/SKILL.md) — Build a throwaway prototype to answer a design question.
- [research](skills/engineering/research/SKILL.md) — Investigate a question using high-trust sources and capture the findings.
- [resolving-merge-conflicts](skills/engineering/resolving-merge-conflicts/SKILL.md) — Resolve an in-progress Git merge or rebase conflict.
- [tdd](skills/engineering/tdd/SKILL.md) — Use test-driven development for features, bugs, and integration tests.
- [wizard](skills/engineering/wizard/SKILL.md) — Generate an interactive wizard for steps only a human can perform.

### Miscellaneous

- [migrate-to-shoehorn](skills/misc/migrate-to-shoehorn/SKILL.md) — Migrate test assertions from `as` to `@total-typescript/shoehorn`.
- [scaffold-exercises](skills/misc/scaffold-exercises/SKILL.md) — Create linted exercise directories with problems, solutions, and explainers.
- [setup-pre-commit](skills/misc/setup-pre-commit/SKILL.md) — Set up Husky, lint-staged, type checking, and tests.

### PKM

- [pkm-curation](skills/pkm/pkm-curation/SKILL.md) — Curate an Obsidian vault with classification, links, and atomic notes.

### Productivity

- [grilling](skills/productivity/grilling/SKILL.md) — Grill the user relentlessly about a plan or design.
- [writing-for-agents](skills/productivity/writing-for-agents/SKILL.md) — Write effective documents for agents.

### Skill authoring

- [effective-agent-skills](skills/skill-authoring/effective-agent-skills/SKILL.md) — Write, review, and debug effective agent skills.

### Thinking and docs

- [brain-to-docs](skills/thinking-and-docs/brain-to-docs/SKILL.md) — Extract project vision, decisions, and preferences into documentation.
- [next-decision](skills/thinking-and-docs/next-decision/SKILL.md) — Drill into the next unresolved decision with choices and a recommendation.
- [prompt-me](skills/thinking-and-docs/prompt-me/SKILL.md) — Ask pointed questions to extract project priorities and concerns.
- [save-idea](skills/thinking-and-docs/save-idea/SKILL.md) — Capture content ideas in the user's content backlog.
