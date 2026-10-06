---
name: bugfix-regression-test
description: "Fix bugs test-first with a focused regression test when practical."
disable-model-invocation: true
---

# Bug-Fix Regression Test

When fixing a bug with a clear, cheap test path, make the broken behavior executable before changing production code. The goal is a focused regression test that fails before the fix and passes after it.

## Workflow

1. **Understand the bug.** Identify the intended behavior, current behavior, affected path, and smallest observable reproduction.
2. **Choose the narrowest executable check.** Inspect existing coverage first and reuse a test that already reproduces the bug. Otherwise, prefer the closest unit, component, integration, or regression test pattern already used for that codepath.
3. **Establish the failing check.** If existing coverage reproduces the bug, run it; otherwise, add the smallest focused regression test encoding intended behavior, not current implementation.
4. **Confirm the failure.** Verify the check fails for the intended reason. If it passes or fails for an unrelated reason, correct the check or reproduction before editing the implementation.
5. **Fix the bug.** Make the smallest production change that satisfies the intended behavior while preserving nearby contracts.
6. **Rerun the regression test.** Confirm the test now passes.
7. **Run nearby validation.** Run relevant adjacent tests, type checks, lint, or scenario checks when the change has broader risk.

## If a Failing Test Is Impractical

If no credible failing test is practical, explain why before fixing and use the closest useful verification instead. Examples include a targeted script, manual reproduction command, browser automation, snapshot comparison, log assertion, or focused integration check. Avoid tests that mostly exercise mocks, encode implementation details, depend on unrelated state, or require disproportionate setup.

## Guardrails

- Do not change tests merely to match a wrong implementation.
- Do not weaken existing assertions unless the expected behavior has genuinely changed and the reason is clear.
- Keep the regression test focused on the bug; avoid broad fixture churn or unrelated coverage expansion.
- If the bug is flaky, make the test deterministic where possible and document the signal being locked down.
- If the bug exposes a broader class of failures, first land the focused regression path, then consider additional sibling coverage.

## Final Response

Report the evidence, not just the outcome:

- Name the failing-before test or executable check and the failure it produced.
- Name the passing-after test run and any nearby validation performed.
- If failing-before evidence could not be demonstrated, state why and describe the closest regression check used instead.
