# Pstack Skills

Personal agent workflow skills.

## User-invoked

- [bugfix-regression-test](bugfix-regression-test/SKILL.md) — Fix bugs test-first with a focused regression test when practical.
- [interrogate](interrogate/SKILL.md) — Use for "interrogate", "adversarial review", "multi-model review", "challenge this", "stress test this code", "find blind spots", or "tear this apart". Uses available subagents for independent, evidence-backed review.

## Model-invoked

- [fix-merge-conflicts](fix-merge-conflicts/SKILL.md) — Resolve merge conflicts non-interactively, validate build and tests, and finalize conflict resolution
- [how](how/SKILL.md) — Use for "how does X work", code walkthroughs before changing something, and placement / ownership / layering questions ("where should this live", "which package owns this", "is this the right layer"). Explains subsystem architecture, runtime flow, onboarding mental models. Can critique architecture. Use why for motivation.
- [reflect](reflect/SKILL.md) — Review a conversation for durable learnings and propose targeted edits to existing agent skills. Use when the user says "reflect", or when a complex workflow, correction, or recoverable dead end produced a reusable lesson.
- [unslop](unslop/SKILL.md) — Cut AI writing patterns while preserving meaning and voice. Use when drafting, editing, or polishing prose, messages, or documentation.
- [why](why/SKILL.md) — Investigate why code exists or behaves this way using cited historical evidence. Use for design rationale, tradeoffs, regressions, postmortems, and data-backed thresholds. Distinguishes motivation from how the code currently works.
