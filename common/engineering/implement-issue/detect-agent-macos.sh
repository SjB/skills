#!/usr/bin/env bash
# Walk the process tree upward from $PPID to find a known agent binary.
# Outputs the agent name on stdout if found, exits 0.
# Outputs nothing and exits 1 if no known agent is found.
#
# macOS version — uses ps(1) since /proc is not available.
# Requires bash 3.2+ (macOS ships bash 3.2).

set -euo pipefail

KNOWN_AGENTS="pi opencode goose codex claude"

pid=$PPID

while [ "$pid" -gt 1 ]; do
    # Get parent PID and command name.
    ppid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ') || ppid=1
    comm=$(ps -o comm= -p "$pid" 2>/dev/null) || { pid=$ppid; continue; }
    # Strip leading path, keep only the basename.
    comm=$(basename "$comm" 2>/dev/null || echo "$comm")

    # Direct match against known binaries.
    for agent in $KNOWN_AGENTS; do
        if [ "$comm" = "$agent" ]; then
            echo "$agent"
            exit 0
        fi
    done

    # If the process is node or bun, inspect full command line for agent names.
    case "$comm" in
        node|bun)
            args=$(ps -o args= -p "$pid" 2>/dev/null) || args=""
            for agent in $KNOWN_AGENTS; do
                case "$args" in
                    *"$agent"*)
                        echo "$agent"
                        exit 0
                        ;;
                esac
            done
            ;;
    esac

    pid=$ppid
done

exit 1
