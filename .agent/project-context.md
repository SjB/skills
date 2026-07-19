# Project Context Pack

Generated: 2026-07-16
Root: /home/sjb/Projects/personal/ws-sjb-skills/wt-master
Working directory: .
Status: fresh

## Purpose

A collection of agent skills (slash commands and behaviors) loaded into Steve Beaulac's AI coding agents. Each skill is a SKILL.md file that teaches the agent how to handle a specific task — from codebase design and TDD to Obsidian PKM workflows and tmux agent launching.

## Project type

- **Agent skill repository** — markdown-defined agent instructions
- Languages: Markdown (100%), one Bash script (detect-agent), one shell script (tmux-open)
- Package managers: none
- Build/test tools: none
- Agent guidance: `AGENTS.md` at root, `docs/invocation.md` for invocation conventions, `docs/agents/` for issue tracker / triage labels / ADR wiki / domain docs

## Structure

```
.
├── AGENTS.md                    # Top-level agent instructions for this repo
├── README.md                    # Project overview, lists user-invoked and model-invoked skills
├── .gitignore                   # Excludes docs/adr/
├── .agent/
│   └── project-context.md       # This file
├── docs/
│   ├── invocation.md            # Model-invoked vs user-invoked definitions
│   ├── agents/
│   │   ├── adr-wiki.md          # ADR wiki setup docs
│   │   ├── domain.md            # Domain docs layout
│   │   ├── issue-tracker.md     # Gitea issue tracker docs
│   │   └── triage-labels.md     # Five-label triage vocabulary
│   └── adr/                     # ADR wiki clone (gitignored)
└── common/
    ├── README.md                # Lists all common skills by invocation type
    ├── engineering/             # Model-invoked: lsp-code-analysis, pkm-curation; User-invoked: commit-staged, implement-issue, project-context-pack, setup-skills
    ├── productivity/            # (currently only README.md)
    ├── pkm/                     # User-invoked: conversation-summary, crit, research-vault, youtube-video-capture; Model-invoked: pkm-curation
    ├── personal/                # (currently only README.md)
    ├── misc/                    # User-invoked: tmux-launch-agent
    ├── in-progress/             # User-invoked: agent-handoff, knowledge-gardener
    └── deprecated/              # Deprecated forge-* and dsp-* skills
```

## Important files

- `AGENTS.md` — Agent entry point that describes structure, categories, and references docs
- `README.md` — Index of all skills divided into user-invoked and model-invoked
- `docs/invocation.md` — Defines the invocation model (disable-model-invocation frontmatter key, human vs model reachability, dependency rules)
- `docs/agents/` — Agent documentation for issue tracker, triage labels, ADR wiki, domain docs
- `common/engineering/project-context-pack/SKILL.md` — The skill that generated this file
- `common/misc/tmux-launch-agent/SKILL.md` — Fork agent CLI into new tmux window (user-invoked)
- `common/misc/tmux-launch-agent/tmux-open` — Reusable script that opens a command in a new tmux window/session

## Commands

- Build: none
- Test: none
- Lint/typecheck: none
- Run/dev: skills are invoked by AI agents — no server or dev command

## Entry points

- `AGENTS.md` — loaded by the AI agent as project instructions (referred to in pi's agent config)
- Each `SKILL.md` under `common/` — referenced by agents via slash commands or auto-invocation

## Search and symbol notes

- All skills are `SKILL.md` files — search with `fd SKILL.md`
- Bucket READMEs: `fd README.md common/`
- Skills are classified as **user-invoked** (`disable-model-invocation: true` in frontmatter) or **model-invoked** (default, no frontmatter flag)
- Dependencies between skills use prose invocation ("Run the `/grilling` skill"), not file cross-references
- Shared reference docs live inside the owning skill's directory; other skills reach that material by invoking the skill

## Files inspected

- `AGENTS.md` — root agent instructions — fresh
- `README.md` — project overview and skill index — fresh
- `docs/invocation.md` — invocation model definitions — fresh
- `.gitignore` — excludes docs/adr/ — fresh
- `common/README.md` — common bucket index — fresh
- `common/misc/README.md` — misc bucket index — fresh
- `.agent/project-context.md` — this file (refreshed from stale 2026-06-25 version)

## Exclusions

- `.git/` — VCS data
- `docs/adr/` — gitignored ADR wiki clone
- `node_modules/`, `dist/`, `build/`, `target/`, `.venv/`, `__pycache__/`, `vendor/`, `coverage/` — not present, but excluded by policy
- `/home/sjb/.agents/skills/` — global install, NOT the source of truth for this repo
- Binary files, large artifacts, credentials, secrets, personal data

## Navigation rules for future agents

- Start with `fd SKILL.md` to find all skills, then narrow by `fd SKILL.md common/<category>/`
- To understand a skill's purpose, read its `SKILL.md` and the bucket `README.md` that indexes it
- For invocation rules (user-invoked vs model-invoked), read `docs/invocation.md`
- For agent-level docs (issue tracker, triage, ADR, domain), check `docs/agents/`
- Do not browse directories file-by-file; use `fd` and `rg` first
- Track every inspected file in this cache
- Re-read a file only when it changed, the cache is stale, or exact details are needed

## Edit boundaries

When cwd is inside this repo, all file edits MUST be scoped to paths under the repo root (`/home/sjb/Projects/personal/ws-sjb-skills/wt-master`). Do NOT touch files under `/home/sjb/.agents/skills/` or `/home/sjb/.pi/` — those are the installed/runtime copies, not the source of truth. The global install is synced separately; this repo is where source edits happen.

## Refresh notes

- This is a markdown-only repo with no build artifacts; refreshes are rarely needed unless skills are added or removed
- To refresh, re-run `tree -a -I '.git' -L 4` and re-read any changed bucket READMEs or SKILL.md files
- The `docs/adr/` directory is gitignored — if ADR data is needed, check the Gitea wiki directly
- If a skill is moved between buckets, update all README.md files that reference it (root, common, source bucket, destination bucket)
