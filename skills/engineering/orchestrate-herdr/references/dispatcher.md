# Dispatcher: find or start the planner

Invocation is `/skill:orchestrate-herdr <spec-ticket> [worker]` (for example, `/skill:orchestrate-herdr 34 obelix`). The spec issue is required. A named worker is the preferred node for a new planner; if omitted or blank, use the current local worker. Never silently select a different machine.

## Find an existing run first

1. Confirm the issue exists, is the parent/spec ticket, and is open. If closed, report completion and do not launch anything.
2. Resolve the named worker with `herdr machine list`; it is the target for a new run. To find an existing run, inspect enabled saved machines using their exact labels/IDs and `herdr --machine <machine> agent list`.
3. Read the issue's `in-progress` label and locate its `.orchestrate/<slug>/run.json` on candidate worker checkouts. Match exact recorded Herdr workspace/pane/agent IDs. Agent listings show runtime identity and status, not the spec issue; use a working directory only to locate a candidate checkout, never as proof of ownership. If the recorded pane no longer exists, match the live `herdr agent list` entry and rewrite `run.json` to it, logging the reconciliation; a stale ID is a reconciliation event, not a mismatch. `herdr machine list` reporting no saved machines means the local session is the worker.
4. If a matching planner is active, monitor it; do not start another. If that planner is this session, the identities have collapsed: continue the run loop here instead of monitoring. If the matching run exists but the label is missing, verify the run identity, add `in-progress`, comment on the reconciliation, and monitor.
5. If `in-progress` is set but no matching agent can be found, do not start a planner. Refresh Herdr and run state to account for propagation delay; if still unmatched, comment on the parent issue with the mismatch and evidence, then stop for human direction. Do not clear the label automatically.
6. If there is no matching agent and no `in-progress` label, reconcile any existing run metadata, issue comments, and Git state. If there is no active or ambiguous work, proceed to start a planner. If anything is uncertain, stop rather than risk duplicate work.

For an untracked agent, do not attach to it or assume it belongs to this spec. Flag it for human review if it appears relevant; otherwise leave it untouched.

## Start a new planner

1. On the selected worker, acquire a per-spec launch claim using an atomic exclusive create under `.orchestrate/`. If another invocation holds the claim, reconcile its owner and run state; never steal an uncertain claim.
2. Create a new sibling pane in the confirmed repository checkout and start a fresh Pi planner agent there. Never use an existing agent pane as the planner. Give the planner the issue number, worker identity, repository path, and references to `run-loop.md` and `state.md`.
3. The planner's first action is to set/verify the spec's `in-progress` label, before reading tickets or dispatching agents. It then records its Herdr IDs in `run.json` and begins the run loop.
4. Confirm the planner reaches `working` and the label is set. Release the launch claim only after confirmed startup. If startup failure is confirmed, release the claim and report the failure. If the outcome is uncertain, retain the claim and stop; do not retry blindly.

## Start confirmation and failures

After launching, confirm the planner reaches `working` and the `in-progress` label is set. Then report its run identity and exit; do not wait for later state changes or monitor its agents. If the machine is unreachable, check it with `herdr machine status`; when authentication is needed, run `herdr machine reconnect <label-or-id>` and verify connectivity. Retry transient connection failures at most twice after the first attempt. If the run cannot be safely identified, comment with the blocker and stop; do not dispatch to a different worker.

Herdr machine commands require an enabled saved machine and reachable, API-compatible Herdr server. A failed connection does not prove a mutation failed; reconcile remote state before retrying.
