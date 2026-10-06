# Skills

Agent skills (slash commands and behaviors) loaded into AI coding agents.

Skills are grouped by invocation type. [User-invoked](docs/invocation.md) skills run only when a person invokes them; model-invoked skills can also be selected automatically.

## Credits

Many of these skills were created or originated by the following people and organizations:
- [Matt Pocock](http://mattpocock.com)
- [poteto](https://github.com/poteto?tab=repositories)

## User-invoked

### Setup

- [setup-skills](skills/setup-skills/SKILL.md) — Configure this repo for the engineering skills, issue tracker, triage label vocabulary, and domain doc layout.

### Engineering

- [thermo-nuclear-code-quality-review](skills/engineering/code-quality-review/SKILL.md) — Run an extremely strict maintainability review for abstraction quality, giant files, and spaghetti-condition growth. Use for a thermo-nuclear code quality review, thermonuclear review, deep code quality audit, or especially harsh maintainability review.
- [commit-staged](skills/engineering/commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [grill-with-docs](skills/engineering/grill-with-docs/SKILL.md) — A relentless interview to sharpen a plan or design, which also creates docs (ADR's and glossary) as we go.
- [implement](skills/engineering/implement/SKILL.md) — Implement a piece of work based on a spec or set of tickets.
- [implement-isolation](skills/engineering/implement-isolation/SKILL.md) — Implement a piece of work based on a spec or set of tickets in isolation.
- [implement-isolation-tmux](skills/engineering/implement-isolation-tmux/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [implement-spec](skills/engineering/implement-spec/SKILL.md) — Implement the result of /to-spec and /to-tickets in code.
- [implementation-orchestrator](skills/engineering/implementation-orchestrator/SKILL.md) — Implements ready-for-agent tracker tickets through isolated worktrees, pull requests, review, conflict resolution, and merge. Use after wayfinder and planning have produced tickets, with or without a ticket ID/URL; no ticket ID/URL means process available tickets. Does not create planning tickets.
- [improve-codebase-architecture](skills/engineering/improve-codebase-architecture/SKILL.md) — Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- [orchestrate-herdr](skills/engineering/orchestrate-herdr/SKILL.md) — Drive a plan from context or @file through a published spec, linked tickets, and one-at-a-time isolated implementation to a merged PR using Herdr and Pi agents.
- [project-context-pack](skills/engineering/project-context-pack/SKILL.md) — Use when the user wants a bounded repo context pack, project map, codebase index, or cached memory file so later work uses fd/rg/tree-sitter/LSP instead of repeated browsing.
- [recipe-diagrams](skills/engineering/recipe-diagrams/SKILL.md) — Recipe diagrams: convert any recipe into a high-resolution Cooking for Engineers-style PNG process-flow table with aligned ingredient streams, preparation branches, joins, temperatures, timings, and finish steps. Use when the user asks for a recipe diagram.
- [security-audit](skills/engineering/security-audit/SKILL.md) — Comprehensive security and correctness audit of a branch's changes. Use for deep review requests, or branch/PR diff audits focused on bugs, breaking changes, security issues, devex regressions, and feature-gate leaks.
- [triage](skills/engineering/triage/SKILL.md) — Move issues and external PRs through a state machine of triage roles, categorise, verify, grill if needed, and write agent-ready briefs.
- [wayfinder](skills/engineering/wayfinder/SKILL.md) — Plan a huge chunk of work (more than one agent session can hold) as a shared map of decision tickets on your issue tracker, and resolve them one at a time until the way to the destination is clear.

### In Progress

- [agent-handoff](skills/in-progress/agent-handoff/SKILL.md) — Hand the current conversation off to a fresh background agent that picks up the work immediately.
- [knowledge-gardener](skills/in-progress/knowledge-gardener/SKILL.md) — Run vault-aware semantic search, synthesis, note creation, linking, and Zettelkasten workflows for this Obsidian vault.

### Misc

- [bro](skills/misc/bro/SKILL.md) — Restate the last message in plain human language, with no jargon.
- [show-me](skills/misc/show-me/SKILL.md) — Help the user understand the current topic visually with concise diagrams, code-shape sketches, and focused HTML artifacts.
- [tmux-launch-agent](skills/misc/tmux-launch-agent/SKILL.md) — Fork a new agent CLI session into a new tmux window, detected from the current agent.
- [visual-verification](skills/misc/visual-verification/SKILL.md) — Verify running desktop UI changes with screenshots and recordings. Use when changing shell styling, layout, panels, menus, notifications, animations, transitions, or capture flows; inspect the artifacts before reporting completion.

### Personal

- [arch-maintenance](skills/personal/arch-maintenance/SKILL.md) — Keep an Arch or CachyOS system updated and healthy with status, check, and update workflows.
- [arch-troubleshooting](skills/personal/arch-troubleshooting/SKILL.md) — Diagnose and repair Arch or CachyOS system problems.

### Pkm

- [conversation-summary](skills/pkm/conversation-summary/SKILL.md) — Save the current conversation as a comprehensive report note in your Obsidian vault, following OKF v0.1 conventions.
- [crit](skills/pkm/crit/SKILL.md) — Run the CRIT framework — give the AI Context, assign it a Role, let it Interview you one question at a time, then issue the Task.
- [research-vault](skills/pkm/research-vault/SKILL.md) — Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked OKF-conformant research packet in the Obsidian vault.
- [youtube-video-capture](skills/pkm/youtube-video-capture/SKILL.md) — Fetch subtitles from a YouTube video, summarize the content, and save both the summary and raw subtitles to the Video bundle in the Obsidian vault. Use when the user wants to capture a YouTube video, mentions "summarize this video", "capture this talk", or pastes a YouTube URL wanting it saved to vault.

### Productivity

- [grill-me](skills/productivity/grill-me/SKILL.md) — A relentless interview to sharpen a plan or design.
- [handoff](skills/productivity/handoff/SKILL.md) — Compact the current conversation into a handoff document for another agent to pick up.
- [to-questionnaire](skills/productivity/to-questionnaire/SKILL.md) — Turn a decision you can't fully answer into a questionnaire for someone else to fill in.
- [wait-what](skills/productivity/wait-what/SKILL.md) — Stop. That last message did not land: re-pitch it.

### Pstack

- [bugfix-regression-test](skills/pstack/bugfix-regression-test/SKILL.md) — Fix bugs test-first with a focused regression test when practical.
- [interrogate](skills/pstack/interrogate/SKILL.md) — Use for "interrogate", "adversarial review", "multi-model review", "challenge this", "stress test this code", "find blind spots", or "tear this apart". Uses available subagents for independent, evidence-backed review.

### Thinking And Docs

- [before-building](skills/thinking-and-docs/before-building/SKILL.md) — Fire the moment the user proposes a build. Instantly surface the 1-3 consequential choices hidden in his idea. Can also be invoked with /before-building.
- [decisions](skills/thinking-and-docs/decisions/SKILL.md) — Ask the agent to list all choices it made during the current work that it is not confident of. Manual-only; invoke with /decisions.
- [level-up](skills/thinking-and-docs/level-up/SKILL.md) — Gauge the user''s technical + product knowledge through 7 adaptive questions, log verbatim answers with honest ratings, and grow a learning plan from the gaps found. Use when the user says "level up", "level-up session", "quiz me", "gauge my knowledge", or wants a new assessment round. Differentiator: this finds and maps gaps; the `teach` skill delivers lessons on them.
- [read-all-adrs](skills/thinking-and-docs/read-all-adrs/SKILL.md) — Read every ADR markdown file in the project's docs/adr/ folder so you have full context on past decisions. Use only when the user explicitly calls it.
- [remind](skills/thinking-and-docs/remind/SKILL.md) — Rewrite the last response simpler and shorter in plain English, prefixed with a 3-5 sentence TLDR of the conversation so far. Manual-only, invoked as /remind.
- [short](skills/thinking-and-docs/short/SKILL.md) — Manually-invoked skill that forces the agent to compress its current answer — strip filler, simplify wording, and cut length while keeping the substance. Use when the user says "short", "shorter", "simpler", "too long", "tl;dr", or wants a more concise version of the previous response.
- [teach](skills/thinking-and-docs/teach/SKILL.md) — Teach the user a new skill or concept, within this workspace.

## Model-invoked

### Engineering

- [code-review](skills/engineering/code-review/SKILL.md) — Review the changes since a fixed point (commit, branch, tag, or merge-base) along two axes: Standards (does the code follow this repo's documented coding standards?) and Spec (does the code match what the originating issue/spec asked for?). Runs both reviews in parallel sub-agents and reports them side by side. Use when the user wants to review a branch, a PR, work-in-progress changes, or asks to "review since X".
- [codebase-design](skills/engineering/codebase-design/SKILL.md) — Shared vocabulary for designing deep modules. Use when the user wants to design or improve a module's interface, find deepening opportunities, decide where a seam goes, make code more testable or AI-navigable, or when another skill needs the deep-module vocabulary.
- [diagnosing-bugs](skills/engineering/diagnosing-bugs/SKILL.md) — Diagnosis loop for hard bugs and performance regressions. Use when the user says "diagnose"/"debug this", or reports something broken/throwing/failing/slow.
- [domain-modeling](skills/engineering/domain-modeling/SKILL.md) — Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a CONTEXT.md, or recording or editing an ADR.
- [dual-review](skills/engineering/dual-review/SKILL.md) — Run two independent, read-only reviews of a branch diff in parallel — correctness/security and maintainability — then synthesize prioritized findings. Use for a second review axis alongside code-review, a combined deep plus code-quality audit, or when the user asks for dual review. Runs both axes as parallel sub-agents so they do not pollute each other's context.
- [forge-cli](skills/engineering/forge-cli/SKILL.md) — Provides copy-paste, non-interactive tea, gh, and glab commands for issue and pull or merge request work. Use whenever a task needs tracker inspection, assignment, labels, comments, reviews, CI, or merge operations.
- [lsp-code-analysis](skills/engineering/lsp-code-analysis/SKILL.md) — Semantic code analysis via LSP. Navigate code (definitions, references, implementations), search symbols, preview refactorings, and get file outlines. Use for exploring unfamiliar codebases or performing safe refactoring.
- [pr](skills/engineering/pr/SKILL.md) — Use when writing a PR body.
- [prototype](skills/engineering/prototype/SKILL.md) — Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check whether a state model or logic feels right, or explore what a UI should look like.
- [research](skills/engineering/research/SKILL.md) — Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
- [resolving-merge-conflicts](skills/engineering/resolving-merge-conflicts/SKILL.md) — Use when you need to resolve an in-progress git merge/rebase conflict.
- [tdd](skills/engineering/tdd/SKILL.md) — Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
- [to-spec](skills/engineering/to-spec/SKILL.md) — Turn the current conversation into a spec and publish it to the project issue tracker: no interview, just synthesis of what you've already discussed. Use when the user wants a spec from the current conversation or an orchestration workflow needs to publish one from context.
- [to-tickets](skills/engineering/to-tickets/SKILL.md) — Break a plan, spec, or the current conversation into tracer-bullet tickets with blocking edges, published to the configured tracker. Use when the user wants tickets from a plan or spec, or an orchestration workflow needs agent-grabbable tickets.
- [wizard](skills/engineering/wizard/SKILL.md) — Generate an interactive bash wizard that walks a human through steps only they can perform. Use when provisioning infrastructure, setting up credentials or CI secrets, walking an unfamiliar third-party dashboard, or running a one-off migration or cutover. Don't invoke this for steps the agent can perform itself.
- [worktrees](skills/engineering/worktrees/SKILL.md) — Manage Git worktrees in a canonical `.bare` repository root. Use when creating, reusing, listing, removing, or repairing worktrees, or when setting up a repository to keep all branch checkouts under one root.
- [write-discoverable-code](skills/engineering/write-discoverable-code/SKILL.md) — |

### Misc

- [migrate-to-shoehorn](skills/misc/migrate-to-shoehorn/SKILL.md) — Migrate test files from `as` type assertions to @total-typescript/shoehorn. Use when user mentions shoehorn, wants to replace `as` in tests, or needs partial test data.
- [scaffold-exercises](skills/misc/scaffold-exercises/SKILL.md) — Create exercise directory structures with sections, problems, solutions, and explainers that pass linting. Use when user wants to scaffold exercises, create exercise stubs, or set up a new course section.
- [setup-pre-commit](skills/misc/setup-pre-commit/SKILL.md) — Set up Husky pre-commit hooks with lint-staged (Prettier), type checking, and tests in the current repo. Use when user wants to add pre-commit hooks, set up Husky, configure lint-staged, or add commit-time formatting/typechecking/testing.

### Pkm

- [pkm-curation](skills/pkm/pkm-curation/SKILL.md) — Curate an Obsidian vault — classify notes, normalize frontmatter, add links, extract atomic notes. Use when curating, batch-processing, reviewing, or doing a serendipity pick.

### Productivity

- [grilling](skills/productivity/grilling/SKILL.md) — Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
- [writing-for-agents](skills/productivity/writing-for-agents/SKILL.md) — Writing documents for agents. Use when creating or editing skills, or modifying AGENTS.md or CLAUDE.md.

### Pstack

- [fix-merge-conflicts](skills/pstack/fix-merge-conflicts/SKILL.md) — Resolve merge conflicts non-interactively, validate build and tests, and finalize conflict resolution
- [how](skills/pstack/how/SKILL.md) — Use for "how does X work", code walkthroughs before changing something, and placement / ownership / layering questions ("where should this live", "which package owns this", "is this the right layer"). Explains subsystem architecture, runtime flow, onboarding mental models. Can critique architecture. Use why for motivation.
- [reflect](skills/pstack/reflect/SKILL.md) — Review a conversation for durable learnings and propose targeted edits to existing agent skills. Use when the user says "reflect", or when a complex workflow, correction, or recoverable dead end produced a reusable lesson.
- [unslop](skills/pstack/unslop/SKILL.md) — Cut AI writing patterns while preserving meaning and voice. Use when drafting, editing, or polishing prose, messages, or documentation.
- [why](skills/pstack/why/SKILL.md) — Investigate why code exists or behaves this way using cited historical evidence. Use for design rationale, tradeoffs, regressions, postmortems, and data-backed thresholds. Distinguishes motivation from how the code currently works.

### Skill Authoring

- [effective-agent-skills](skills/skill-authoring/effective-agent-skills/SKILL.md) — How to write effective agent skills — what to do, what not to do, anatomy, progressive disclosure, design patterns, anti-patterns, testing, security. Read this whenever a skill (Claude Skill, Agent Skill, SKILL.md) is being created, edited, reviewed, or debugged. Use when the user says "create a skill", "new skill", "update this skill", "improve a skill", "why isn't my skill triggering", or anything else involving authoring or editing SKILL.md files.

### Thinking And Docs

- [brain-to-docs](skills/thinking-and-docs/brain-to-docs/SKILL.md) — Use when the user wants to extract project vision, decisions, and preferences from his head into clear documentation (README + ADRs) through a back-and-forth Q&A loop. Triggers on "brain-to-docs", "build out the docs", "extract the vision", "let's document this project".
- [next-decision](skills/thinking-and-docs/next-decision/SKILL.md) — Drill open decisions one at a time — present the most important decision not yet clarified, give the top four choices, state a preference, ask the user. Use when the user says "next decision", "one decision at a time", or a plan has several unresolved choices. Differentiator: forward-looking; the decisions skill is retrospective (choices already made). Can be invoked with /next-decision.
- [prompt-me](skills/thinking-and-docs/prompt-me/SKILL.md) — Prompt the user with pointed questions to extract what is in his head about a project — remaining work, what is being avoided, what really matters, what does not. Use when the user says "prompt me", "ask me questions", or wants the agent to figure out priorities by questioning him.
- [save-idea](skills/thinking-and-docs/save-idea/SKILL.md) — Quickly capture a content idea into ~/code/content from any repo or chat. Video ideas go to VIDEO-IDEAS.md; smaller podcast topics, guest ideas, questions, and AI observations go to TOPICS.md. Every entry gets a source line referencing the chat and repo it came from. Use when the user says "/save-idea", "save this idea", "video idea", "add a topic", "write this down for a video/podcast". Differentiator: appends to the user''s content backlog — not a reminder, task, or general note tool.
