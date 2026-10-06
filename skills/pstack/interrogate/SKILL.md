---
name: interrogate
description: "Use for \"interrogate\", \"adversarial review\", \"multi-model review\", \"challenge this\", \"stress test this code\", \"find blind spots\", or \"tear this apart\". Uses available subagents for independent, evidence-backed review."
disable-model-invocation: true
---

# Interrogate

Run an adversarial code review through the harness's subagent capability. The deliverable is a synthesized verdict; do not apply suggested changes.

## 1. Determine scope

Use the target the user named. Otherwise:

- For an explicit diff or files, review those.
- On a feature branch, review `git diff <base>...HEAD`, choosing the repository's actual base branch.
- For recent work, identify the relevant changes and context first.

Include the diff and only the surrounding files reviewers need to understand it.

## 2. State intent

Write one short paragraph describing what the change is meant to accomplish. Derive this from the user's request, commit/PR description, and code. If the intent is still unclear, ask before launching reviewers; reviewers assess execution, not whether the goal is worthwhile.

## 3. Run independent reviews

Check which subagent roles, models, and parallel execution options the current harness makes available. Use only reviewers that can actually be launched. Prefer independent reviewers using distinct models when available; if only one reviewer/model is available, run one review and report that limitation rather than implying model diversity.

Read `references/reviewer-prompt.md`, `references/rubric.md`, and `references/code-quality-review.md`. Give every reviewer the same intent, code, rubric, and quality lens. Launch the reviews in parallel using the harness's native subagent mechanism, with fresh or isolated context when supported. Ask reviewers to report findings only and not edit files; use enforced read-only permissions when the harness provides them. If parallel execution is unavailable, run reviewers sequentially. Collect their completed results before synthesizing the verdict.

## 4. Synthesize and judge

Parse all findings, deduplicate them, identify independent agreement and disagreement, and check each against the actual code and intent. Read `references/lead-judgment.md` before classifying. You are the lead reviewer: accept or reject reviewer claims based on repository context, not vote count alone.

Classify every finding:

- **Act on** — actionable correctness, security, or maintainability issue for this change.
- **Consider** — legitimate but with a meaningful tradeoff or uncertain priority.
- **Noted** — valid but low-impact or premature.
- **Dismissed** — incorrect, nitpicky, or missing context; state why.

## Output

### Intent
>
> [One-paragraph intent]

### Reviewers

- [Reviewer or model]: [N findings]

### Act On

[Finding, source agent(s), and impact.]

### Consider

[Finding, source agent(s), and tradeoff.]

### Noted

[Brief list.]

### Dismissed

[Finding and concise rationale.]

### Agreement Map

[Where reviewers agreed or diverged; state whether the review was single- or multi-model.]
