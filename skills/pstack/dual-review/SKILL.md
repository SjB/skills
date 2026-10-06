---
name: dual-review
description: "Run parallel correctness/security and maintainability reviews of a branch diff, then synthesize findings. Use for double review, or combined deep and code-quality audits."
disable-model-invocation: true
---

# Thermos for Pi

Run two independent, read-only reviews in parallel, then synthesize their findings. Invoke explicitly with `/skill:dual-review`.

## Requirements

- Pi's `pi-subagents` extension must be enabled.
- A configured subagent named `reviewer` must be available.
- Do not silently fall back to a single-parent review. If either requirement is missing, stop and tell the user what to enable/configure.

## Workflow

1. Determine the exact review scope from the request, PR, base branch, or current changes. Do not broaden a diff-scoped request.
2. Gather the diff and the contents of changed files, plus only the surrounding context needed to trace behavior. Read the `security-audit` and `code-quality-review` skill files so their full rubrics can be included in the respective child tasks. Never make a child guess where a rubric lives.
3. Before launching anything, use the subagent management tool with `action: "list"`. Confirm that `reviewer` is available. If not, explain that the user must enable `pi-subagents` and provide/configure a `reviewer` agent.
4. Launch one Pi subagent workflow with `workflowScript` and `runs.all()` for these two tasks, both using agent `reviewer`:
   - **Correctness/security:** follow the full `security-audit` rubric; review only added or modified code for bugs, breakages, security, devex regressions, and feature-gate leaks.
   - **Maintainability:** follow the full `code-quality-review` rubric; focus on structural quality, simplification, boundaries, and codebase health.
5. Give both tasks the same scoped diff and changed-file context. Give each only its assigned rubric and a distinct task. Request prioritized findings with file/line evidence; do not ask the reviewers to edit files.
6. Wait for both runs to complete before presenting a final synthesis. Deduplicate overlapping findings, resolve disagreements using the evidence, and put the highest-priority findings first. If there are no findings, say so and note review scope/limitations. Do not restate child summaries already visible to the user.

## Review constraints

- Report issues only in code added or modified in the review scope.
- Follow the correctness rubric's PR/MR discussion rule only after its independent review and only when a PR/MR exists and there are medium-or-higher findings.
- Do not present uncertain or unfinished research as a finding. Do not fix reported issues unless the user asks.
