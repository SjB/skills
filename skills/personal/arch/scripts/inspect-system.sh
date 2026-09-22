#!/usr/bin/env bash
set -u

DOTFILES_ROOT="${1:-${DOTFILES_ROOT:-$HOME/.local/share/dotfiles}}"

section() {
	printf '\n[%s]\n' "$1"
}

section "system"
if [[ -r /etc/os-release ]]; then
	# shellcheck disable=SC1091
	. /etc/os-release
	printf 'name=%s\nid=%s\nid_like=%s\n' "${NAME:-unknown}" "${ID:-unknown}" "${ID_LIKE:-unknown}"
else
	printf 'os_release=unavailable\n'
fi
printf 'kernel=%s\narch=%s\n' "$(uname -r)" "$(uname -m)"

section "package-manager"
if command -v pacman >/dev/null 2>&1; then
	printf 'pacman=%s\ninstalled_packages=%s\n' "$(command -v pacman)" "$(pacman -Qq 2>/dev/null | wc -l)"
	orphans="$(pacman -Qdtq 2>/dev/null || true)"
	if [[ -n "$orphans" ]]; then
		printf 'orphan_candidates=%s\n' "$(printf '%s\n' "$orphans" | wc -l)"
	else
		printf 'orphan_candidates=0\n'
	fi
else
	printf 'pacman=unavailable\n'
fi

section "services"
if command -v systemctl >/dev/null 2>&1; then
	failed="$(systemctl --failed --no-legend --plain 2>/dev/null || true)"
	if [[ -n "$failed" ]]; then
		printf '%s\n' "$failed"
	else
		printf 'failed_units=none\n'
	fi
else
	printf 'systemctl=unavailable\n'
fi

section "storage"
if command -v df >/dev/null 2>&1; then
	df -hP / 2>/dev/null | tail -n 1
else
	printf 'df=unavailable\n'
fi

section "dotfiles-and-mise"
if [[ -d "$DOTFILES_ROOT" && -f "$DOTFILES_ROOT/mise.toml" ]]; then
	printf 'dotfiles_root=%s\n' "$DOTFILES_ROOT"
	[[ -f "$DOTFILES_ROOT/config/mise/config.toml" ]] && printf 'mise_config=present\n' || printf 'mise_config=missing\n'
	[[ -f "$DOTFILES_ROOT/packages/sjb-dev.packages" ]] && printf 'dev_packages=present\n' || printf 'dev_packages=missing\n'
	if command -v mise >/dev/null 2>&1; then
		printf 'mise=%s\n' "$(command -v mise)"
		tools="$(cd "$DOTFILES_ROOT" && mise ls 2>/dev/null || true)"
		if [[ -n "$tools" ]]; then
			printf 'mise_installed_tools=%s\n' "$(printf '%s\n' "$tools" | grep -c .)"
		else
			printf 'mise_ls=failed\n'
		fi
	else
		printf 'mise=unavailable\n'
	fi
else
	printf 'dotfiles_root=not-found\n'
fi

section "optional-tools"
for tool in paru checkupdates smartctl lsblk; do
	if command -v "$tool" >/dev/null 2>&1; then
		printf '%s=present\n' "$tool"
	else
		printf '%s=missing\n' "$tool"
	fi
done
