---
name: orchestrate-herdr
description: "Start or monitor a Herdr/Pi planner for a published spec ticket. Invocation: /skill:orchestrate-herdr ISSUE [WORKER]; omitted worker uses the current local worker."
disable-model-invocation: true
---

# Orchestrate a spec with Herdr

This skill takes a tracker issue number and optional Herdr worker node. It checks whether a planner is already running for that spec; if so, it monitors it. Otherwise it starts a planner. Re-run the same command after an orchestrator outage to reconnect monitoring.

The **orchestrator** is the agent session invoking this skill. The **planner** is a fresh agent on the worker node that coordinates the spec workflow. Implementer, reviewer, and merger agents do scoped tasks. Never attach to or resume an existing agent; monitor it through Herdr's read-only agent commands.

Read these references before acting:

- `references/dispatcher.md` — discover an existing run or safely start a planner.
- `references/run-loop.md` — implement and close the spec.
- `references/state.md` — worker-side run metadata, event log, claims, and recovery.

## Prerequisites

The selected worker must have Herdr, Git, the target repository and credentials, this skill, and an authenticated forge CLI (`tea`, `gh`, or `glab`). Run the `forge-cli` preflight there. If a prerequisite, machine, or run identity is missing or ambiguous, stop with actionable guidance; do not guess or dispatch.

## Workflow

1. Validate the spec issue and worker, then follow `references/dispatcher.md` to find or start its planner.
2. Monitor the planner and its scoped agents using Herdr's list/wait/get/read commands. Do not attach, prompt, resume, or otherwise control existing agents.
3. Keep operational events in the worker's `.orchestrate/<slug>/`; use issue and PR comments for communication as defined in `references/run-loop.md`.
4. Continue until the parent spec issue is closed or human action is required. The planner removes the `in-progress` label as it closes the spec. Retain run metadata and logs unless the user explicitly asks to delete them.

There is no background service. After the orchestrator returns, invoke the same skill with the spec issue and worker node to resume monitoring.
