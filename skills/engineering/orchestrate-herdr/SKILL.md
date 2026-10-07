---
name: orchestrate-herdr
description: "Start a Herdr/Pi planner for a published spec ticket. Invocation: /skill:orchestrate-herdr ISSUE [WORKER]; omitted worker uses the current local worker."
disable-model-invocation: true
---

# Orchestrate a spec with Herdr

This skill takes a tracker issue number and optional Herdr worker node. It checks whether a planner is already running for that spec; if so, it reports that and exits. Otherwise it starts a planner and exits after confirming startup. The planner runs independently; there is no need to monitor it.

The **planner**  runs on the worker node and coordinates the spec workflow. It delegates implementation, review, and merge work to subagents—not separate CLI agents or Herdr-launched agents. Never attach to, prompt, or resume an existing agent.

When the invoking session is itself the planner — the local worker started the planner in this session, or no saved or matching machine and pane exists — the two identities collapse. Do not go looking for a planner to monitor: run the run-loop directly in this session, skip the launch-claim and monitor ceremony, and record the session as both orchestrator and planner in `run.json`.

Read these references before acting:

- `references/dispatcher.md` — discover an existing run or safely start a planner.
- `references/run-loop.md` — implement and close the spec.
- `references/state.md` — worker-side run metadata, event log, claims, and recovery.

## Prerequisites

The selected worker must have Herdr, Git, the target repository and credentials, this skill, and an authenticated forge CLI (`tea`, `gh`, or `glab`). Run the `forge-cli` preflight there. If a prerequisite, machine, or run identity is missing or ambiguous, stop with actionable guidance; do not guess or dispatch.

## Workflow

1. Validate the spec issue and worker, then follow `references/dispatcher.md` to find or start its planner.
2. If a planner is already active for the spec, report that and exit. Do not attach, prompt, resume, or monitor it.
3. If starting a planner, confirm it reaches `working`, then report the run identity and exit. The planner owns the workflow from there; retain run metadata and logs unless the user explicitly asks to delete them.
