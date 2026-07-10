# Skills

A collection of agent skills (slash commands and behaviors) loaded into Steve Beaulac's agents.

## User-invoked

- [agent-handoff](common/in-progress/agent-handoff/SKILL.md) — Hand the current conversation off to a fresh background agent that picks up the work immediately.
- [audio-product-dsp](common/deprecated/audio-production-dispatcher/SKILL.md) — Dispatch audio product DSP hardware/software engineering requests to the best specialist workflow with measurable product-focused outputs.
- [conversation-summary](common/pkm/conversation-summary/SKILL.md) — Save the current conversation as a comprehensive report note in your Obsidian vault, following OKF v0.1 conventions.
- [crit](common/pkm/crit/SKILL.md) — Brainstorm with AI using the CRIT framework to generate and evaluate ideas.
- [dsp-research-engineering](common/deprecated/dsp-research-dispatcher/SKILL.md) — Route DSP hardware and software research-engineering requests to the best specialist workflow and return a unified, decision-ready output.
- [forge-router](common/deprecated/forge-router/SKILL.md) — High-level guidance for choosing the right forge skill.
- [implement-issue](common/engineering/implement-issue/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [knowledge-gardener](common/in-progress/knowledge-gardener/SKILL.md) — Run vault-aware semantic search, synthesis, note creation, linking, and Zettelkasten workflows for this Obsidian vault.
- [project-context-pack](common/engineering/project-context-pack/SKILL.md) — Use when the user wants a bounded repo context pack, project map, codebase index, or cached memory file so later work uses fd/rg/tree-sitter/LSP instead of repeated browsing.
- [research-vault](common/pkm/research-vault/SKILL.md) — Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked OKF-conformant research packet in the Obsidian vault.
- [setup-skills](common/engineering/setup-skills/SKILL.md) — Configure this repo for the engineering skills, set up its issue tracker, triage label vocabulary, and domain doc layout. Run once before first use of the other engineering skills.
- [tmux-launch-agent](common/misc/tmux-launch-agent/SKILL.md) — Fork a new agent CLI session into a new tmux window, detected from the current agent.

## Model-invoked

- [lsp-code-analysis](common/engineering/lsp-code-analysis/SKILL.md) — Semantic code analysis via LSP. Navigate code (definitions, references, implementations), search symbols, preview refactorings, and get file outlines. Use for exploring unfamiliar codebases or performing safe refactoring.
- [pkm-curation](common/pkm/pkm-curation/SKILL.md) — Curate an Obsidian vault — classify notes, normalize frontmatter, add wikilinks, extract atomic notes. Use when curating, batch-processing, reviewing, or doing a serendipity pick.
- [forge-gitea](common/deprecated/forge-gitea/SKILL.md) — Use the Gitea CLI (`tea`) to interact with Gitea issues, pull requests, releases, CI, and repository state.
- [forge-github](common/deprecated/forge-github/SKILL.md) — Use the GitHub CLI (`gh`) to interact with GitHub issues, pull requests, releases, CI, and repository state.
- [forge-interaction](common/deprecated/forge-interaction/SKILL.md) — Use when the user wants forge work such as opening a PR, creating or listing issues, checking CI, looking at the repo, pushing a branch, publishing changes, or making a release on GitHub or Gitea. This skill now delegates to specialized skills for better predictability.
- [forge-preferences](common/deprecated/forge-preferences/SKILL.md) — Use with forge-interaction to apply Steve's personal or project-specific GitHub/Gitea remote, CLI, issue, PR, and release preferences.
