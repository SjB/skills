#!/usr/bin/env bash
set -u

remote="$(git remote get-url origin 2>/dev/null || true)"
if [[ -z "$remote" ]]; then
	printf '%s\n' 'No origin remote found; run this inside a checked-out forge repository.' >&2
	exit 1
fi

choice="${DEV_WORKFLOW_FORGE:-}"
if [[ -z "$choice" ]]; then
	case "$remote" in
	*github.com*) choice=gh ;;
	*gitlab.com* | *gitlab.*) choice=glab ;;
	*) choice=tea ;;
	esac
fi

case "$choice" in
tea | gh | glab) ;;
*)
	printf 'Unsupported DEV_WORKFLOW_FORGE=%s (use tea, gh, or glab).\n' "$choice" >&2
	exit 1
	;;
esac

if ! command -v "$choice" >/dev/null 2>&1; then
	printf 'Required forge CLI not found: %s\n' "$choice" >&2
	exit 1
fi

case "$choice" in
tea) "$choice" login list >/dev/null 2>&1 || {
	printf '%s authentication check failed.\n' "$choice" >&2
	exit 1
} ;;
gh) "$choice" auth status >/dev/null 2>&1 || {
	printf '%s authentication check failed.\n' "$choice" >&2
	exit 1
} ;;
glab) "$choice" auth status >/dev/null 2>&1 || {
	printf '%s authentication check failed.\n' "$choice" >&2
	exit 1
} ;;
esac

printf 'forge=%s\nremote=%s\n' "$choice" "$remote"
