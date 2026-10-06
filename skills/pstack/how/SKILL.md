---
name: how
description: "Use for \"how does X work\", code walkthroughs before changing something, and placement / ownership / layering questions (\"where should this live\", \"which package owns this\", \"is this the right layer\"). Explains subsystem architecture, runtime flow, onboarding mental models. Can critique architecture. Use why for motivation."
---

# How

Explore the codebase to answer "how does X work?" questions. Produce clear architectural explanations at the level of a senior engineer onboarding onto a subsystem. Enough to build a working mental model, not annotated source code.

Two modes:

1. **Explain** (default). Explore the codebase and produce a clear explanation
2. **Critique.** Explain first, then spawn multiple models to independently identify architectural issues

## Explain Mode

### Step 1. Understand the Question and Assess Complexity

Parse what the user is asking about:

- "How does the rate limiter work?", a subsystem
- "How do we handle billing for on-demand usage?", a feature flow
- "How is the auth service structured?", an architectural overview
- "Walk me through what happens when a user submits a form", a runtime trace

Identify the scope. If ambiguous, state your best-guess interpretation before exploring. Let the user redirect if you're off.

**Assess complexity:**

- **Simple** (one module or narrow function question): explore and explain in one pass. Go to Step 2b.
- **Complex** (multiple modules/services or cross-cutting flow): use parallel explorers if this harness supports subagents; otherwise explore the distinct slices yourself. Go to Step 2a.

When in doubt, lean simple.

### Step 2a. Explore (complex questions only)

Decompose the question into 2–4 distinct exploration angles so explorers don't duplicate work. For example, a rate limiter might split into data/state, request enforcement, and configuration/metrics. Use fewer angles for narrow questions. Use this harness's supported subagent mechanism to run read-only explorers in parallel, if available; follow its own instructions for dispatch, permissions, model selection, and result collection. Don't assume a particular agent name, model, tool name, or dispatch syntax. Give each explorer the base prompt in `references/explorer-prompt.md` plus its angle.

If subagents aren't available, investigate the angles yourself. Stop each exploration when you can describe the full path without hand-waving; record components, flow, files read, and non-obvious behavior.

Then proceed to Step 3.

### Step 2b. Direct Explain (simple questions)

Explore the code directly and write the explanation. Read `references/explainer-prompt.md` for the communication style and output format.

Proceed to Step 4.

### Step 3. Synthesize (complex questions only)

Synthesize the exploration findings into one coherent explanation. If explorers ran, reconcile overlap and contradictions, checking the code where needed. Read `references/explainer-prompt.md` for the full prompt template.

### Step 4. Present

Present the explainer's output to the user. You may lightly edit for clarity or add context from the conversation, but don't substantially rewrite. The explainer's communication is the product.

### Output Format

Follow this structure, adapted to the question. Not every section is needed for every question.

**Overview.** 1-2 paragraphs. What it is, what it does, why it exists. Enough to decide whether to keep reading.

**Key Concepts.** The important types, services, or abstractions. Brief definition of each. Not exhaustive, just the ones needed to understand the rest.

**How It Works.** The core of the explanation. Walk through the flow: what triggers it, what happens step by step, where data goes, the decision points. Prose, not pseudocode. Reference specific files and functions so the reader can go look, but don't dump code blocks unless a snippet is genuinely necessary.

**Where Things Live.** A brief map of the relevant files/directories. Not every file, just the ones needed to start working in this area.

**Gotchas.** Non-obvious or surprising things that would trip someone up. Historical context that explains why something looks weird. Known sharp edges.

## Critique Mode

Triggered when the user asks for architectural issues, problems, or improvements, not just understanding.

### Step 1. Explain First

Run the full explain flow above (Steps 1-4). You must understand the architecture before critiquing it.

### Step 2. Spawn Critics

After the explanation is complete, use this harness's supported subagent mechanism to run independent, read-only architectural critics in parallel, if available. Follow its instructions for dispatch, permissions, model selection, and result collection; don't assume specific models or dispatch syntax. Read `references/critic-prompt.md` for the prompt template. Each critic gets:

1. The explanation from Step 1
2. The relevant file paths
3. The rubric in `references/critique-rubric.md`

If subagents aren't available, critique the architecture yourself against the rubric.

### Step 3. Lead Judgment

You're a pragmatic lead, not an aggregator.

Categorize findings:

- **Act on.** Architectural problems worth fixing now
- **Consider.** Real concerns, but the cost/benefit is unclear
- **Noted.** Valid observations, low priority
- **Dismissed.** Wrong, missing context, or style preference

Present the explanation first (from Step 1), then the critique verdict below it. The explanation should stand on its own; someone who just wants to understand the system shouldn't wade through critique.
