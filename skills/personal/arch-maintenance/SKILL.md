---
name: arch-maintenance
description: Keep an Arch or CachyOS system updated and healthy with status, check, and update workflows.
disable-model-invocation: true
---

# Arch Maintenance

User-invoked only. Local machine. For diagnosing and fixing a broken system, use the `arch-troubleshooting` skill instead.

## First move

1. Read `../arch/references/safety.md` for distro detection, the safety contract, and redaction rules.
2. Resolve `DOTFILES_ROOT` as described there.
3. Run `bash ../arch/scripts/inspect-system.sh "$DOTFILES_ROOT"` for the read-only baseline.

## Modes

- `status` — baseline health report.
- `check` — run `bash ../arch/scripts/check-system.sh "$DOTFILES_ROOT"`; report available updates, cache size, orphans, reboot need, and `.pacnew` files. No mutation.
- `update` — full official update, then separately approved AUR and mise reconciliation.
- `report` — save a redacted detailed report. Create `$HOME/.local/state/arch-system-management/reports/` and write `$(date +%Y-%m-%dT%H%M%S).md`.

If the request is ambiguous, run `status` and ask which mode is wanted.

## Update workflow

1. Run the baseline, `check-system.sh`, and the pacman-lock checks from `../arch/references/safety.md`.
2. Present the official update plan — exact command `sudo pacman -Syu`, affected scope, rollback, post-check — and obtain approval.
3. Run `sudo pacman -Syu`; require exit 0.
4. Verify: `pacman -Qkk` and a `find /etc -name '*.pacnew' -o -name '*.pacsave'` scan. Report `.pacnew` files for manual merge; never merge them automatically.
5. Separately present AUR changes (`paru -Qua`); if approved, run `paru -Sua` (AUR only — the official update already ran) and verify.
6. Separately present mise reconciliation; if approved, run `mise install` from `$DOTFILES_ROOT` and verify.
7. Offer approved mise tasks individually; never run all tasks as a bundle.
8. Check reboot need and failed units with `check-system.sh`.
9. Append `timestamp, command, result, verification` to `$HOME/.local/state/arch-system-management/mutations.log` (no secrets).

Declare success only after the post-checks pass. A reboot is a recommendation, never an implicit action.

## Mise and dotfiles

Read `../arch/references/mise.md` when the request concerns mise, dotfiles, or development tools.

## Output

1. detected system
2. findings
3. proposed next action
4. approval needed, if any
5. verification result
