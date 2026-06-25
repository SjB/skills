# Project Context Pack

Generated: 2026-06-25
Root: /home/sjb/Documents/ai-workflows/skills
Working directory: .
Status: fresh

## Purpose
A collection of agent skills (slash commands and behaviors) loaded into Steve Beaulac's AI coding agents. Each skill is a SKILL.md file that teaches the agent how to handle a specific task — from codebase design and TDD to Obsidian PKM workflows and forge interaction.

## Project type
- **Agent skill repository** — markdown-defined agent instructions
- Languages: Markdown (100%)
- Package managers: none
- Build/test tools: none
- Agent guidance: `AGENTS.md` at root, `docs/invocation.md` for invocation conventions, `docs/agents/` for issue tracker / triage labels / ADR wiki / domain docs

## Structure
```
.
├── AGENTS.md                    # Top-level agent instructions for this repo
├── README.md                    # Project overview, lists user-invoked and model-invoked skills
├── .gitignore                   # Excludes docs/adr/
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
    ├── engineering/             # Model-invoked: forge-interaction, project-context-pack; also sub-skills for codebase-design, domain-modeling, tdd, triage, etc.
    ├── productivity/            # User-invoked: grill-me, handoff, writing-great-skills; Model-invoked: grilling
    ├── pkm/                     # User-invoked: conversation-summary, crit, knowledge-gardener, research-vault
    ├── personal/                # User-invoked: pkm-curation; Model-invoked: forge-preferences
    └── deprecated/              # Deprecated skills (audio-production-dispatcher, dsp-research-dispatcher, forge-*)
```

## Important files
- `AGENTS.md` — Agent entry point that describes structure, categories, and references docs
- `README.md` — Index of all skills divided into user-invoked and model-invoked (recently updated to fix broken links, add missing skills, correct invocation classification)
- `docs/invocation.md` — Defines the invocation model (disable-model-invocation frontmatter key, human vs model reachability, dependency rules)
- `docs/agents/` — Agent documentation for issue tracker, triage labels, ADR wiki, domain docs
- `common/engineering/project-context-pack/SKILL.md` — The currently running skill
- `common/engineering/codebase-design/SKILL.md` — Deep module design vocabulary (referenced by other skills)
- `common/engineering/domain-modeling/SKILL.md` — Domain modeling with ADRs and CONTEXT files
- `common/engineering/tdd/SKILL.md` — Test-driven development discipline
- `common/productivity/grilling/SKILL.md` — Relentless plan/design interview (model-invoked, triggers)
- `common/productivity/writing-great-skills/SKILL.md` — Reference for writing/editing skills

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
- `README.md` — project overview — updated (all links fixed, missing skills added, invocation corrected)
- `docs/invocation.md` — invocation model definitions — fresh
- `.gitignore` — excludes docs/adr/ — fresh
- `common/engineering/README.md` — engineering bucket index — updated (all engineering skills added, misclassified skills corrected)
- `common/README.md` — common bucket index — updated (links fixed, missing skills added)
- `common/productivity/README.md` — productivity bucket index — fresh (was already correct)
- `common/pkm/README.md` — pkm bucket index — updated (pkm-curation added)
- `common/personal/README.md` — personal bucket index — updated (noted both skills moved elsewhere)
- `common/deprecated/README.md` — deprecated bucket index — updated (all forge skills added)
- All `SKILL.md` files — frontmatter checked for invocation status

## Exclusions
- `.git/` — VCS data
- `docs/adr/` — gitignored ADR wiki clone
- `node_modules/`, `dist/`, `build/`, `target/`, `.venv/`, `__pycache__/`, `vendor/`, `coverage/` — not present, but excluded by policy
- Binary files, large artifacts, credentials, secrets, personal data

## Navigation rules for future agents
- Start with `fd SKILL.md` to find all skills, then narrow by `fd SKILL.md common/<category>/`
- To understand a skill's purpose, read its `SKILL.md` and the bucket `README.md` that indexes it
- For invocation rules (user-invoked vs model-invoked), read `docs/invocation.md`
- For agent-level docs (issue tracker, triage, ADR, domain), check `docs/agents/`
- Do not browse directories file-by-file; use `fd` and `rg` first
- Track every inspected file in this cache
- Re-read a file only when it changed, the cache is stale, or exact details are needed

## Refresh notes
- This is a markdown-only repo with no build artifacts; refreshes are rarely needed unless skills are added or removed
- To refresh, re-run `tree -a -I '.git' -L 4` and re-read any changed bucket READMEs or SKILL.md files
- The `docs/adr/` directory is gitignored — if ADR data is needed, check the Gitea wiki directly
- All README.md files were updated on 2026-06-25 to fix broken links, add missing skills, and correct invocation classification
- If a skill is moved between buckets, update all README.md files that reference it (root, common, source bucket, destination bucket)
