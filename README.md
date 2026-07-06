# Skills

A collection of agent skills (slash commands and behaviors) loaded into Steve Beaulac's agents.

## User-invoked

- [conversation-summary](common/pkm/conversation-summary/SKILL.md) — Summarize the current AI conversation into a new Obsidian markdown note and matching transcript file.
- [crit](common/pkm/crit/SKILL.md) — Brainstorm with AI using the CRIT framework to generate and evaluate ideas.
- [grill-me](common/productivity/grill-me/SKILL.md) — A relentless interview to sharpen a plan or design.
- [grill-with-docs](common/engineering/grill-with-docs/SKILL.md) — A relentless interview to sharpen a plan or design, which also creates docs (ADRs and glossary) as we go.
- [handoff](common/productivity/handoff/SKILL.md) — Compact the current conversation into a handoff document for another agent to pick up.
- [implement-issue](common/engineering/implement-issue/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a ready-for-agent issue end-to-end.
- [improve-codebase-architecture](common/engineering/improve-codebase-architecture/SKILL.md) — Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- [knowledge-gardener](common/pkm/knowledge-gardener/SKILL.md) — Run vault-aware semantic search, synthesis, note creation, linking, and Zettelkasten workflows for this Obsidian vault.
- [pkm-curation](common/pkm/pkm-curation/SKILL.md) — Curate an Obsidian vault — classify notes, normalize frontmatter, add wikilinks, extract atomic notes. Use when curating, batch-processing, reviewing, or doing a serendipity pick.
- [project-context-pack](common/engineering/project-context-pack/SKILL.md) — Build and refresh a bounded repo context memory file so agents use disciplined search instead of repeated browsing.
- [research-vault](common/pkm/research-vault/SKILL.md) — Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked Obsidian research packet.
- [setup-skills](common/engineering/setup-skills/SKILL.md) — Configure this repo for the engineering skills, set up its issue tracker, triage label vocabulary, and domain doc layout.
- [to-issues](common/engineering/to-issues/SKILL.md) — Break a plan, spec, or PRD into independently-grabbable issues on the project issue tracker using tracer-bullet vertical slices.
- [to-prd](common/engineering/to-prd/SKILL.md) — Turn the current conversation into a PRD and publish it to the project issue tracker — no interview, just synthesis of what you've already discussed.
- [triage](common/engineering/triage/SKILL.md) — Move issues and external PRs through a state machine of triage roles — categorise, verify, grill if needed, and write agent-ready briefs.
- [writing-great-skills](common/productivity/writing-great-skills/SKILL.md) — Reference for writing and editing skills well — the vocabulary and principles that make a skill predictable.

**Deprecated / user-invoked:**
- [forge-router](common/deprecated/forge-router/SKILL.md) — High-level guidance for choosing the right forge skill.

## Model-invoked

- [codebase-design](common/engineering/codebase-design/SKILL.md) — Shared vocabulary for designing deep modules.
- [domain-modeling](common/engineering/domain-modeling/SKILL.md) — Build and sharpen a project's domain model.
- [grilling](common/productivity/grilling/SKILL.md) — Interview the user relentlessly about a plan or design.
- [resolving-merge-conflicts](common/engineering/resolving-merge-conflicts/SKILL.md) — Resolve an in-progress git merge/rebase conflict.
- [tdd](common/engineering/tdd/SKILL.md) — Test-driven development.

**Deprecated / user-invoked:**
- [audio-product-dsp](common/deprecated/audio-production-dispatcher/SKILL.md) — Dispatch audio product DSP hardware/software engineering requests to the best specialist workflow with measurable product-focused outputs.
- [dsp-research-engineering](common/deprecated/dsp-research-dispatcher/SKILL.md) — Route DSP hardware and software research-engineering requests to the best specialist workflow and return a unified, decision-ready output.
- [forge-gitea](common/deprecated/forge-gitea/SKILL.md) — Work with Gitea repositories, issues, pull requests, releases, and CI.
- [forge-github](common/deprecated/forge-github/SKILL.md) — Work with GitHub repositories, issues, pull requests, releases, and CI.
- [forge-interaction](common/deprecated/forge-interaction/SKILL.md) — Work safely with GitHub and Gitea repositories, issues, pull requests, releases, and remote forge state.
- [forge-preferences](common/deprecated/forge-preferences/SKILL.md) — Apply Steve's personal or project-specific GitHub/Gitea forge preferences.
