---
name: why
description: 'Investigate why code exists or behaves this way using cited historical evidence. Use for design rationale, tradeoffs, regressions, postmortems, and data-backed thresholds. Distinguishes motivation from how the code currently works.'
---

# Why

Investigate the motivation and intent behind code. `how` answers what code does; `why` traces the forces that shaped it. Return evidence with calibrated confidence, not a satisfying story.

## Method

### 1. Anchor the question

Identify the target files, line ranges, symbols, and the user's question. If the target is vague, state your best interpretation from conversation context and proceed. Gather recent history and PR links before delegation:

```bash
git blame -L <start>,<end> <file>
git log --follow -p -- <file>
git log --oneline -20 -- <file>
git log -1 --format=%B <commit>
```

For substantive PRs, inspect the full description and discussion (for example, `gh pr view <number>`). Record commits, PRs, and linked ticket IDs as seed context.

### 2. Map available evidence sources

Inspect the tools available in this Pi session and map them to the seven categories below. Git history is always available; other sources may be exposed through MCP or other configured tools. Use tool descriptions to identify their scope. Record ambiguous mappings. A missing source is a coverage gap, not a negative search result.

Before searching issues with `gh` or another tracker CLI, check the project instructions and `docs/agents/issue-tracker.md`. Follow that file as the authority for the issue tracker and its commands. If `docs/agents/issue-tracker.md` is absent, tell the user to run the project's issue-tracker setup skill; do not guess the tracker or substitute GitHub Issues. Continue the other available evidence searches and report the issue-tracker gap.

### 3. Investigate in parallel

For broad investigations, delegate independent source categories in parallel, then use a separate synthesizer. Use the harness's available subagent mechanism; assign each investigator one category and provide the task context and report format below. If delegation is unavailable, perform the available searches directly and disclose the reduced coverage.

Give each investigator:

- The user's question and code anchor (files, symbols, commits, PRs, ticket IDs).
- The base prompt in `references/investigator-prompt.md`.
- Its category playbook from `references/sources/` (indexed by `references/source-playbook.md`).
- `references/sources/incident-postmortem.md` when the target is defensive (retries, timeouts, null checks, rate limits, feature flags, OOM handling).

Each investigator owns one category. Ask for sources searched, exact queries, verbatim quotes, precise citations, gaps, contradictions, and leads for other investigators. For available categories, run the searches even if they seem unlikely to apply; record null results. Skip only when no matching tool/source is available or the source is demonstrably irrelevant, and state why.

The seven categories:

1. **Source control** — git history, PRs, code comments, and tests; implementation-time rationale and review debate. Always investigate.
2. **Issue / ticket tracker** — product or business forcing functions, customer needs, compliance, and scope changes. Use the configured project tracker only.
3. **Long-form documents** — specs, RFCs, ADRs, postmortems, and meeting notes; written design rationale.
4. **Real-time team chat** — deliberation and incident decisions that never reached a document.
5. **Infrastructure observability** — metrics, monitors, logs, traces, and incidents; runtime signals and thresholds.
6. **Error tracking** — issues, events, stack traces, and releases; exception trajectories that motivated changes.
7. **Product analytics / warehouse** — usage, experiments, billing, and data distributions; user and data realities behind code or thresholds.

### 4. Synthesize

Give the synthesizer all investigator reports, including null results and justified skips, plus the question and code anchor. Include `references/epistemics.md` and `references/synthesizer-prompt.md`. The synthesizer should spot-check citations when the relevant source is accessible and preserve disagreements rather than choosing a tidy narrative.

### 5. Present

Use the output format below. Keep confidence language intact. If the question precedes a code change, finish with a **Preserve / Change / Avoid / Risk** constraint set grounded in the lineage evidence.

## Epistemics

- Cite every claim about intent with a commit, PR, ticket, document, chat permalink, or code comment. Without direct support, label it as inference.
- Prefer direct quotations and precise locations. Hedge claims based on indirect evidence.
- Surface contradictions and competing explanations; do not retrofit intent from code shape.
- Report searched-but-empty sources and unavailable sources separately. “No relevant results” is meaningful only when you say what you searched.
- Treat user-suggested explanations as hypotheses to verify, not conclusions.

Read `references/epistemics.md` for the confidence framework. The investigator and synthesizer prompt templates and source-specific playbooks are linked in the steps above.

## Output

**The Question** — concise restatement.

**The Code in Question** — file paths, line ranges, and key symbols.

**What We Found (direct evidence)** — cited claims supported explicitly by a source.

**What We Can Reasonably Infer** — indirect claims, with the inference chain and hedged phrasing.

**Competing Hypotheses** — evidence for and against each, when the record supports multiple readings.

**What We Don't Know** — specific unanswered questions and evidence gaps.

**Sources Consulted** — one line per category, including empty and unavailable searches. Format: `- <Source>: <queries/items searched>. <finding, no relevant results, or skipped with reason>.`

For example, report a missing tracker as: `- Issue tracker: not searched. Project has no docs/agents/issue-tracker.md; asked the user to run the issue-tracker setup skill. GitHub Issues was not assumed.`

## Reference files

- `references/epistemics.md` — confidence tiers and phrasing.
- `references/investigator-prompt.md` — investigator task template.
- `references/source-playbook.md` and `references/sources/*.md` — category playbooks.
- `references/synthesizer-prompt.md` — synthesis task and output format.
