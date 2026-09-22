#!/usr/bin/env bash
set -u

section() {
	printf '\n[%s]\n' "$1"
}

section "updates"
if command -v checkupdates >/dev/null 2>&1; then
	printf 'official_updates=%s\n' "$(checkupdates 2>/dev/null | wc -l)"
else
	printf 'checkupdates=unavailable (do not substitute pacman -Sy)\n'
fi
if command -v paru >/dev/null 2>&1; then
	printf 'aur_updates=%s\n' "$(paru -Qua 2>/dev/null | wc -l)"
else
	printf 'paru=unavailable\n'
fi

section "cache"
if [[ -d /var/cache/pacman/pkg ]]; then
	du -sh /var/cache/pacman/pkg 2>/dev/null
else
	printf 'cache=unavailable\n'
fi

section "reboot-needed"
# Compare the running kernel against its own installed package, not the newest
# kernel in /usr/lib/modules (a fallback kernel can be newer without being booted).
running="$(uname -r)"
pkg=""
for p in linux-cachyos linux-lts linux-zen linux; do
	if pacman -Q "$p" >/dev/null 2>&1; then
		pkg="$p"
		break
	fi
done
if [[ -n "$pkg" ]]; then
	installed="$(pacman -Q "$pkg" | awk '{print $2}')"
	# cachyos/lts/zen place the flavor after pkgrel: "7.2.5-1-cachyos" vs "7.2.5-1"
	if [[ "$running" == "$installed"* ]]; then
		printf 'reboot=not-needed (running=%s, %s=%s)\n' "$running" "$pkg" "$installed"
	else
		printf 'reboot=recommended (running=%s, %s=%s)\n' "$running" "$pkg" "$installed"
	fi
else
	printf 'reboot=unknown\n'
fi

section "pacnew"
found="$(find /etc -name '*.pacnew' -o -name '*.pacsave' 2>/dev/null || true)"
if [[ -n "$found" ]]; then
	printf '%s\n' "$found"
else
	printf 'pacnew=none\n'
fi

section "orphans"
if command -v pacman >/dev/null 2>&1; then
	printf 'orphan_candidates=%s\n' "$(pacman -Qdtq 2>/dev/null | wc -l)"
fi

section "failed-units"
if command -v systemctl >/dev/null 2>&1; then
	systemctl --failed --no-legend --plain 2>/dev/null || true
fi
