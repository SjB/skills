#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
skill="$root/skills/dev-workflow/SKILL.md"
shared_skill="$root/skills/forge-cli/SKILL.md"
recipes=(
	"$root/skills/forge-cli/references/tea.md"
	"$root/skills/forge-cli/references/gh.md"
	"$root/skills/forge-cli/references/glab.md"
)

[[ -f "$skill" && -f "$shared_skill" && -f "${recipes[0]}" && -f "${recipes[1]}" && -f "${recipes[2]}" ]] || {
	echo 'Missing skill or reference file' >&2
	exit 1
}
head -1 "$skill" | grep -qx -- '---'
grep -q '^name: dev-workflow$' "$skill"
grep -q '^description: ' "$skill"
head -1 "$shared_skill" | grep -qx -- '---'
grep -q '^name: forge-cli$' "$shared_skill"
grep -q '^description: ' "$shared_skill"
node -e 'JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"))' "$root/package.json"
bash -n "$root/skills/forge-cli/scripts/detect-forge.sh"

printf '%s\n' 'dev-workflow skill is valid'
