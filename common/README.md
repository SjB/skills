# Common Skills

Skills that work in all CLI agents.

## User-invoked

- [agent-handoff](in-progress/agent-handoff/SKILL.md) — Hand the current conversation off to a fresh background agent that picks up the work immediately.
- [audio-product-dsp](deprecated/audio-production-dispatcher/SKILL.md) — Dispatch audio product DSP hardware/software engineering requests to the best specialist workflow with measurable product-focused outputs.
- [commit-staged](engineering/commit-staged/SKILL.md) — Commit staged files with a conventional commit message.
- [conversation-summary](pkm/conversation-summary/SKILL.md) — Save the current conversation as a comprehensive report note in your Obsidian vault, following OKF v0.1 conventions.
- [crit](pkm/crit/SKILL.md) — Brainstorm with AI using the CRIT framework to generate and evaluate ideas.
- [forge-router](deprecated/forge-router/SKILL.md) — High-level guidance for choosing the right forge skill.
- [implement](engineering/implement/SKILL.md) — Implement a piece of work based on a spec or set of tickets in isolation.
- [implement-issue](engineering/implement-issue/SKILL.md) — Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues.
- [knowledge-gardener](in-progress/knowledge-gardener/SKILL.md) — Run vault-aware semantic search, synthesis, note creation, linking, and Zettelkasten workflows for this Obsidian vault.
- [project-context-pack](engineering/project-context-pack/SKILL.md) — Use when the user wants a bounded repo context pack, project map, codebase index, or cached memory file so later work uses fd/rg/tree-sitter/LSP instead of repeated browsing.
- [research-engineering](deprecated/dsp-research-dispatcher/SKILL.md) — Route DSP hardware and software research-engineering requests to the best specialist workflow and return a unified, decision-ready output.
- [research-vault](pkm/research-vault/SKILL.md) — Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked OKF-conformant research packet in the Obsidian vault.
- [setup-skills](engineering/setup-skills/SKILL.md) — Configure this repo for the engineering skills, set up its issue tracker, triage label vocabulary, and domain doc layout. Run once before first use of the other engineering skills.
- [tmux-launch-agent](misc/tmux-launch-agent/SKILL.md) — Fork a new agent CLI session into a new tmux window, detected from the current agent.
- [youtube-video-capture](pkm/youtube-video-capture/SKILL.md) — Fetch subtitles from a YouTube video, summarize the content, and save both the summary and raw subtitles to the Video bundle in the Obsidian vault.

## Model-invoked

- [forge-gitea](deprecated/forge-gitea/SKILL.md) — Work with Gitea repositories, issues, pull requests, releases, and CI.
- [forge-github](deprecated/forge-github/SKILL.md) — Work with GitHub repositories, issues, pull requests, releases, and CI.
- [forge-interaction](deprecated/forge-interaction/SKILL.md) — Use when the user wants forge work such as opening a PR, creating or listing issues, checking CI, looking at the repo, pushing a branch, publishing changes, or making a release on GitHub or Gitea. This skill now delegates to specialized skills for better predictability.
- [forge-preferences](deprecated/forge-preferences/SKILL.md) — Use with forge-interaction to apply Steve's personal or project-specific GitHub/Gitea remote, CLI, issue, PR, and release preferences.
- [pkm-curation](pkm/pkm-curation/SKILL.md) — Curate an Obsidian vault — classify notes, normalize frontmatter, add links, extract atomic notes. Use when curating, batch-processing, reviewing, or doing a serendipity pick.
