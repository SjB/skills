---
name: dual-review
description: "Run two independent, read-only reviews of a branch diff in parallel — correctness/security and maintainability — then synthesize prioritized findings. Use for a second review axis alongside code-review, a combined deep plus code-quality audit, or when the user asks for dual review. Runs both axes as parallel sub-agents so they do not pollute each other's context."
---

# Dual review

Two independent, read-only reviews of the diff between `HEAD` and a fixed point, then a synthesis:

- **Correctness/security** — bugs, breakages, security gaps, devex regressions, and feature-gate leaks in the changed code.
- **Maintainability** — structural quality, simplification, boundaries, and codebase health in the changed code.

Together with `code-review` (spec, standards) these form the four review axes. Both axes run as **parallel sub-agents**, then this skill aggregates their findings.

The issue tracker should have been provided to you. If `docs/agents/issue-tracker.md` is missing, tell the user to run `setup-skills`.

## Process

### 1. Pin the fixed point

Whatever the user said is the fixed point (a commit SHA, branch name, tag, `main`, `HEAD~5`, etc.). If they did not specify one, ask for it.

Capture the diff command once: `git diff <fixed-point>...HEAD` (three-dot, against the merge-base). Note the commit list via `git log <fixed-point>..HEAD --oneline`.

Confirm the fixed point resolves (`git rev-parse <fixed-point>`) and the diff is non-empty before spawning anything. A bad ref or empty diff fails here, not inside two sub-agents.

### 2. Gather context

Gather the diff and the contents of changed files, plus only the surrounding context needed to trace behavior. Read each changed file at its current version. Do not review files outside the diff scope.

### 3. Spawn both sub-agents in parallel

Both get the same scoped diff and changed-file context and a distinct task.

**Correctness/security brief:** "Report, per file/hunk where relevant, every bug, breakage, security gap, devex regression, or feature-gate leak in the added or modified code. Cite the hunk and explain the concrete failure or exposure. Distinguish hard defects from judgement calls. Under 400 words."

**Maintainability brief:** "Report, per file/hunk where relevant, structural quality problems in the added or modified code: duplication, large or over-generalized units, weak boundaries, primitive obsession, speculative generality, or other smells that will cost to maintain. Name the problem and quote the hunk; flag hard violations from judgement calls. Under 400 words."

Ask each to report prioritized findings with file/line evidence and to **not** edit files.

### 4. Synthesize

Wait for both runs before synthesizing. Deduplicate overlapping findings, resolve disagreements using the evidence, and list the highest-priority findings first. Present them under `## Correctness/security` and `## Maintainability` headings. If there are no findings, say so and note the review scope and its limitations. Do not restate child summaries already visible to the user.

## Review constraints

- Report issues only in code added or modified within the review scope.
- Do not present uncertain or unfinished research as a finding.
- Do not fix reported issues unless the user asks.
