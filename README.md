# Skills

Agent skills (slash commands and behaviors) loaded into my agent.

## User-invoked

- [agent-handoff](common/in-progress/agent-handoff/SKILL.md) — Hand the current conversation off to a fresh background agent that picks up the work immediately.
- [commit-staged](common/engineering/commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [conversation-summary](common/pkm/conversation-summary/SKILL.md) — Save the current conversation as a comprehensive report note in your Obsidian vault, following OKF v0.1 conventions.
- [crit](common/pkm/crit/SKILL.md) — Brainstorm with AI using the CRIT framework to generate and evaluate ideas.
- [implement-isolation](common/engineering/implement-isolation/SKILL.md) — Implement a piece of work based on a spec or set of tickets in isolation.
- [implement-isolation-tmux](common/engineering/implement-isolation-tmux/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [knowledge-gardener](common/in-progress/knowledge-gardener/SKILL.md) — Run vault-aware semantic search, synthesis, note creation, linking, and Zettelkasten workflows for this Obsidian vault.
- [project-context-pack](common/engineering/project-context-pack/SKILL.md) — Build a bounded repo context pack (project map, codebase index, cached memory file) so later work uses fd/rg/tree-sitter/LSP instead of repeated browsing.
- [research-vault](common/pkm/research-vault/SKILL.md) — Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked OKF-conformant research packet in the Obsidian vault.
- [setup-skills](common/engineering/setup-skills/SKILL.md) — Configure this repo for the engineering skills, set up its issue tracker, triage label vocabulary, and domain doc layout. Run once before first use of the other engineering skills.
- [tmux-launch-agent](common/misc/tmux-launch-agent/SKILL.md) — Fork a new agent CLI session into a new tmux window, detected from the current agent.
- [youtube-video-capture](common/pkm/youtube-video-capture/SKILL.md) — Fetch subtitles from a YouTube video, summarize the content, and save both the summary and raw subtitles to the Video bundle in the Obsidian vault.

## Model-invoked

- [lsp-code-analysis](common/engineering/lsp-code-analysis/SKILL.md) — Semantic code analysis via LSP. Navigate code (definitions, references, implementations), search symbols, preview refactorings, and get file outlines. Use for exploring unfamiliar codebases or performing safe refactoring.
- [pkm-curation](common/pkm/pkm-curation/SKILL.md) — Curate an Obsidian vault — classify notes, normalize frontmatter, add links, extract atomic notes. Use when curating, batch-processing, reviewing, or doing a serendipity pick.
