---
name: arch-troubleshooting
description: Diagnose and repair Arch or CachyOS system problems.
disable-model-invocation: true
---

# Arch Troubleshooting

User-invoked only. Local machine. For routine maintenance and updates, use the `arch-maintenance` skill instead.

## First move

1. Read `../arch/references/safety.md` for distro detection, the safety contract, and redaction rules.
2. Resolve `DOTFILES_ROOT` as described there.
3. Run `bash ../arch/scripts/inspect-system.sh "$DOTFILES_ROOT"` for the read-only baseline before investigating.

## Discipline

Observe → rank causes → gather targeted evidence → propose → verify. Show ranked causes before testing any of them; proceed with the ranking if the user is away.

- `diagnose <target>` — baseline plus targeted checks for `boot`, `packages`, `kernel`, `graphics`, `audio`, `network`, `storage`, or `services`.
- `repair <target>` — propose a repair for package recovery, failed systemd units, initramfs regeneration, boot configuration, or network restart; apply only after approval and the safety contract.

## Targeted evidence

- boot/service: `journalctl -b` and `journalctl -b -1` for the relevant unit; `systemctl status <unit>`.
- packages: transaction errors, lock ownership, sync state; never partial upgrades.
- kernel: running vs installed kernel, initramfs presence, bootloader config.
- graphics/audio/network: identify the active device, driver, service, and recent relevant journal entries before suggesting any change.

## Repairs

Each repair must state: observation, ranked cause, evidence, proposed change, reversibility, verification. Repairs are limited to reversible, scoped actions. After each approved repair, run its targeted verification and stop if it fails.

## Output

1. observation
2. ranked causes with evidence
3. proposed change
4. approval needed
5. verification result
