---
name: crit
description: Run the CRIT framework — give the AI Context, assign it a Role, let it Interview you one question at a time, then issue the Task.
disable-model-invocation: true
---

## Purpose

CRIT is a four-step prompt framework by Geoff Woods: **Context, Role, Interview,
Task**. The sequence front-loads thinking before execution — the AI learns your
world, takes a specific lens, interviews you to surface what matters, then acts.

The insight: most people skip to Task and get generic output. The Interview
step — one question at a time, max three — is where the signal lives.

## Steps

Run these four steps in order when the user invokes `/crit`.

### 1. Context — Give the AI your world

Ask the user: "What should I know about you, your goals, your audience, and any
constraints?"

Capture the answer in one paragraph. More detail is better.

**Completion criterion**: One paragraph covering identity, goal, audience, and
constraints — confirmed by the user.

### 2. Role — Assign a viewpoint

Ask the user: "What role should I take?"

Guide toward a specific lens — "strategy coach who uncovers blind spots,"
"editor who cuts fluff," "architect who finds leverage points." Not "be
helpful."

**Completion criterion**: A single sentence assigning a named role that implies
a specific viewpoint.

### 3. Interview — One question at a time

Instruct yourself: "Ask me no more than three questions, one at a time, to
clarify what I'm trying to achieve."

Ask one question. Wait for the answer. Then ask the next. Max three. Do not
batch them.

This step forces the user to slow down and think, and teaches the AI what
actually matters.

**Completion criterion**: 1-3 questions asked and answered, one at a time.
Stop asking when the user signals readiness or you've asked three.

### 4. Task — Issue the assignment

Ask the user: "What's the task?"

Guide toward a short, clear, slightly uncomfortable prompt that asks the AI to
*think*, not just write. Reference the preceding interview.

> "Based on our conversation, give me three non-obvious actions I can take.
> Make them surprising but realistic."

Execute the task.

**Completion criterion**: Task executed and result delivered to the user.
