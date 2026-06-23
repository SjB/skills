---
name: project-context-pack
description: Use when the user wants a bounded repo context pack, project map, codebase index, cached memory file, or fewer repeated codebase searches.
---

# Project Context Pack

Create or refresh a bounded project memory file, then use it as the navigation map for the repo.

## Target

Default cache path: `.agent/project-context.md` at the project root.

Use a user-named path when provided. If the user did not explicitly ask for a cache file, ask before the first write into the repo. Never write secrets, credentials, private keys, tokens, browser data, personal data, or raw `.env*` content into the cache.

## Procedure

1. **Root.** Prefer `git rev-parse --show-toplevel`; otherwise use `pwd`. Completion: the pack records the absolute root and current relative working directory.
2. **Survey.** Use `fd` and `rg` first; fall back to `find` and `grep`. Respect ignore files by default. Exclude `.git`, dependency directories, build outputs, caches, generated files, binaries, and large artifacts. Completion: the pack has a bounded file inventory and top-level tree before broad file reads.
3. **Classify.** Detect language, framework, package manager, build/test tools, docs, agent guidance, and likely entry points from filenames and small config reads. Completion: every project-type claim cites at least one file.
4. **Read selectively.** Read only high-value files by default: README, agent guidance, package/build config, docs index, main entry points, and files directly relevant to the user's current request. Cap per-file and total content. Completion: every included file has a recorded reason.
5. **Index before browsing.** For code questions, prefer tree-sitter or LSP when available. Otherwise use `rg` for definitions, exports, imports, routes, tests, commands, TODOs, and error strings. Completion: the pack has search or symbol notes before any broad source reading.
6. **Cache.** Create or update the memory file with the template below. Completion: the file records timestamp, root, status, commands/searches used, files inspected, exclusions, and next navigation rules.
7. **Reuse.** Before future exploration, read the cache first. If stale or insufficient, refresh the smallest relevant section instead of rebuilding everything. Completion: subsequent work uses the cache or explains why it was bypassed.

## Navigation discipline

- Do not wander file-by-file. Start with the cache, `fd`, `rg`, tree-sitter, or LSP.
- Track inspected files in the memory file.
- Prefer narrow searches over whole-file reads.
- Prefer symbol outlines and matching snippets over full content.
- Re-read a file only when it changed, the cache is stale, or exact details are needed.
- Ask before full-content extraction, large scans, or sensitive-file inspection.

## Useful command patterns

```bash
root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$root"

date -Iseconds

# Inventory
fd --type f --hidden --exclude .git 2>/dev/null || find . -type f -not -path './.git/*'
tree -a -I '.git|node_modules|dist|build|target|.venv|__pycache__|vendor|coverage' -L 3

# Project signals
fd '^(README|AGENTS|CLAUDE|GEMINI|package.json|pyproject.toml|Cargo.toml|go.mod|Makefile|justfile|docker-compose.yml)$'

# Search before reading
rg -n "TODO|FIXME|HACK|XXX"
rg -n "^(export |class |def |function |interface |type |trait |struct |enum )"
rg -n "main\(|if __name__ == .__main__.|export default|module.exports"
```

## Memory file template

```markdown
# Project Context Pack

Generated: <timestamp>
Root: <absolute root>
Working directory: <relative path>
Status: <fresh|partial|stale>

## Purpose
<What this repo appears to do.>

## Project type
<Languages/frameworks/package managers and evidence.>

## Structure
<Bounded tree or directory summary.>

## Important files
- <path> — <why it matters>

## Commands
- Build: <command or unknown>
- Test: <command or unknown>
- Lint/typecheck: <command or unknown>
- Run/dev: <command or unknown>

## Entry points
- <path or symbol> — <evidence>

## Search and symbol notes
<Useful rg/tree-sitter/LSP findings.>

## Files inspected
- <path> — <reason> — <freshness note>

## Exclusions
<Skipped directories, large files, generated files, secrets policy.>

## Navigation rules for future agents
<How to answer common questions in this repo without repeated browsing.>

## Refresh notes
<What to refresh next and what is likely stale.>
```
