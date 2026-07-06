---
name: agent-handoff
description: Hand the current conversation off to a fresh background agent that picks up the work immediately.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

## Invocation

```
/skill:agent-handoff [focus description]
```

Arguments are optional. If provided, they describe what the next session should focus on and the summary is tailored accordingly.

## Process

### 1. Assess the conversation

Review what has been done, what remains, and any user-provided focus. Identify existing artifacts that capture the work so far (PRDs, plans, ADRs, issues, commits, diffs) so they can be referenced rather than duplicated.

If the user passed arguments, treat them as the priority or scope for the next session.

Completion criterion: The conversation is assessed — what's done, what's left, and the user's focus (if any) are identified.

### 2. Compose the handoff summary

Write a summary of the current state so a fresh agent can continue the work without reading the full conversation. Organise it with these sections:

- **Current state** — what was accomplished, branch/commit, what's working
- **Next steps** — what needs to be done next, in priority order
- **Open questions** — decisions still needed, unknowns, trade-offs
- **Suggested skills** — a bullet list of skills the next agent should invoke (e.g. `/tdd`, `/code-review`)
- **References** — paths or URLs to existing artifacts (PRDs, plans, ADRs, issues, commits, diffs). Do **not** duplicate their content — reference them.

The summary is a **compass**, not a copy: it points the next agent where to go, it does not replay where you've been. Any content already captured in the referenced artifacts does not belong here.

Redact any sensitive information: API keys, passwords, personally identifiable information.

Completion criterion: The summary covers all required sections, references existing artifacts without duplicating them, and contains no sensitive information.

### 3. Launch the background agent

Use the [`tmux-launch-agent`](../misc/tmux-launch-agent/SKILL.md) skill to fork a fresh agent seeded with the summary:

```
/skill:tmux-launch-agent --name "<descriptive-title>" <handoff-summary>
```

- `--name` is **required** — use a short descriptive title (e.g. `"Fix login bug"`, `"Implement user roles"`). This sets the display name in the job list, session picker, and terminal title.
- The handoff summary from step 2 becomes the new agent's initial prompt.

Completion criterion: `tmux new-window` exits 0 and a new tmux window appears with the handoff summary as the agent's prompt.
