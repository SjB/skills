# Worker-side run state and recovery

The worker node is the source of truth. Keep state under `.orchestrate/<slug>/` in the target repository checkout, outside product commits and PRs. Use a stable issue-derived slug such as `spec-34`; do not mirror state on the orchestrator node.

## Files

- `run.json` — minimal recovery metadata: spec issue ID/URL, repository identity, worker label/ID, planner's Herdr agent/pane/workspace IDs, and each tracked child subagent's role, issue ID, subagent run ID, branch, and worktree.
- `events.jsonl` — append-only structured operational events: timestamp, actor/task, action, outcome, and relevant Herdr/Git/tracker IDs. No pane transcripts, copied ticket bodies, plans, or handoff prose.

The issue tracker is canonical for ticket status, acceptance criteria, decisions, and communication. Keep agent handoffs and blockers in comments on the relevant task issue; use PR comments for review discussion; use parent-spec comments for milestone rollups. Do not create local handoff files or duplicate tracker content in `run.json`.

## Claim and label

Before creating a planner, acquire a per-spec launch claim under `.orchestrate/` with an atomic exclusive create. The claim only serializes startup; it is not a second progress record. Record its owner and issue ID. Never steal an uncertain claim.

The new planner's first action is to set/verify the parent's `in-progress` label, before reading tickets or dispatching work. After confirmed startup and recording the planner's Herdr IDs, release the launch claim. Release a claim after startup failure only when failure and absence of a running planner are confirmed. Keep it and escalate when the result is uncertain.

If the parent has `in-progress` but no matching agent is found, do not start a replacement or clear the label. Comment with the mismatch and wait for the user's explicit retry decision. If a matching agent exists but the label is missing, verify the run record, add the label, and comment on the repair.

## Persist and recover

Append a structured event after each consequential side effect and enough identity data to match the run to Herdr. The worker log records activity while the orchestrator is unavailable; agents continue posting comments to the tracker.

On every invocation or restart:

1. Read the parent issue, labels, and relevant comments.
2. Inspect the worker's `run.json` and event log.
3. Query Herdr for the planner and match its exact recorded IDs; inspect the planner's Pi subagent runs for child status. Do not infer ownership from a matching working directory.
4. Reconcile tracker and Git state before deciding to start a planner. If the worker is unreachable or identities/state disagree, report the blocker and stop rather than guessing.

If a matching live planner exists, report that it is already running and exit; do not attach to, prompt, or resume it. The planner manages its own subagents. If there is no matching agent and no `in-progress` label, reconcile any stale run record; start a fresh planner only when no active or ambiguous work remains and a new atomic claim is acquired.

Retain `run.json` and `events.jsonl` after completion. The planner removes `in-progress` while closing the parent spec only after all tickets are complete, verified, and merged. Delete retained run state only at the user's explicit request.
