---
name: project-context-pack
description: Use when the user wants a bounded repo context pack, project map, codebase index, or cached memory file so later work uses fd/rg/tree-sitter/LSP instead of repeated browsing.
disable-model-invocation: true
---

# Project Context Pack

Create or refresh a bounded project memory file, then use it to navigate the codebase with discipline.

## Output target

Default cache path: `.agent/project-context.md` at the project root.

If the user names another path, use that path. If writing into the repo is risky or unexpected, ask before writing. Never write secrets into the cache.

## Procedure

1. **Find the root.** Prefer `git rev-parse --show-toplevel`; otherwise use `pwd`. Completion: you know the root and current relative working directory.
2. **Inventory cheaply.** Use `fd` and `rg` first; fall back to `find` and `grep`. Respect ignore files by default. Exclude `.git`, dependency directories, build outputs, caches, generated files, binaries, and large artifacts. Completion: you have a bounded file inventory and top-level tree without opening many files.
3. **Classify the project.** Detect language, framework, package manager, build/test tools, docs, agent guidance, and likely entry points from filenames and small config reads. Completion: the pack names the project type and the files that justify it.
4. **Read selectively.** Read only high-value files by default: README, agent guidance, package/build config, docs index, main entry points, and files directly relevant to the user's current request. Cap per-file and total content. Completion: every included file has a reason.
5. **Index symbols before browsing.** For code questions, prefer tree-sitter or LSP when available. Otherwise use `rg` patterns for definitions, exports, imports, routes, tests, commands, TODOs, and error strings. Completion: the pack has symbol/search notes before any broad source reading.
6. **Write the memory file.** Create or update the cache with the template below. Completion: the file exists and records when it was generated, commands/searches used, files inspected, and next navigation rules.
7. **Use the cache.** Before future exploration, read the cache first. If stale or insufficient, refresh the smallest relevant section instead of rebuilding everything. Completion: subsequent work cites the cache and avoids repeated file browsing.

## Navigation discipline

- Do not wander file-by-file. Start with `fd`, `rg`, tree-sitter, LSP, or the cache.
- Track inspected files in the memory file.
- Prefer narrow searches over whole-file reads.
- Prefer symbol outlines and matching snippets over full content.
- Re-read a file only when it changed, the cache is stale, or the exact details are needed.
- Ask before full-content extraction, large scans, or including sensitive files such as `.env`, credentials, private keys, tokens, browser profiles, or personal data.

## Useful command patterns

```bash
root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$root"

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
