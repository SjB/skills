# Safety contract

Shared by the arch-maintenance and arch-troubleshooting skills.

## Distro detection

Read `/etc/os-release`; use `ID` and `ID_LIKE`. Support Arch and CachyOS. On any other distro, stay read-only. Confirm `pacman` is available before any package operation.

## DOTFILES_ROOT

Set `DOTFILES_ROOT` to `$DOTFILES_ROOT` when it points to a directory containing `mise.toml`; otherwise `$HOME/.local/share/dotfiles` when it contains `mise.toml`. If neither, report it and treat mise checks as unavailable.

## Read first, mutate second

Before every mutation show: the exact command, affected scope, risk, rollback/recovery option, and the post-check. Wait for explicit approval.

## Privilege

Run as the normal user; use `sudo` only for the individual privileged command. Never store passwords or edit sudo policy.

## Forbidden

- `pacman -Sy` standalone (partial upgrade) — full updates are `sudo pacman -Syu` only
- `--noconfirm`, `--force`, `--overwrite`, `-Rdd`
- deleting `/var/lib/pacman/db.lck` without diagnosing
- disk formatting, partitioning, filesystem repair, kernel removal, firewall/security disablement, destructive deletion

## Pacman lock

If `/var/lib/pacman/db.lck` exists or `pacman` errors with "unable to lock database":

1. `pgrep -a pacman` and `pgrep -a paru` — is a package process active? If yes, wait for it; never kill it or delete the lock.
2. If no process is active, the lock is stale. Report it and ask before removing it.

## Config edits

Create a backup, show a diff, get approval, then verify the result.

## Backups

Before risky work, detect snapshots/backups and warn when none exist. Do not create backup infrastructure automatically.

## Failure

If a mutation fails, stop mutations, preserve evidence, run only independent read-only checks, and report the exact failed command.

## Verification

Every mutation ends with the smallest check that fails if the change broke: exit code, then `pacman -Qkk` for package integrity, and a `find /etc -name '*.pacnew' -o -name '*.pacsave'` scan after upgrades. Report `.pacnew`/`.pacsave` files for manual merge; never merge them automatically.

## Redaction

Redact identity (usernames, hostnames), network identifiers (IP/MAC), storage serials/UUIDs, credentials, and environment values. Device paths and package/service names stay — they are diagnostic evidence.
