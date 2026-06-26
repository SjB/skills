#!/usr/bin/env bash
# Walk the process tree upward from $PPID to find a known agent binary.
# Outputs the agent name on stdout if found, exits 0.
# Outputs nothing and exits 1 if no known agent is found.

set -euo pipefail

# Dispatch table: binary names we recognize.
KNOWN_AGENTS="pi opencode goose codex claude"

pid=$PPID

while [ "$pid" -gt 1 ]; do
    # Read command name and parent PID from /proc.
    comm=$(cat /proc/$pid/comm 2>/dev/null) || { pid=1; continue; }
    ppid=$(awk '{print $4}' /proc/$pid/stat 2>/dev/null) || ppid=1

    # Direct match against known binaries.
    for agent in $KNOWN_AGENTS; do
        if [ "$comm" = "$agent" ]; then
            echo "$agent"
            exit 0
        fi
    done

    # If the process is node or bun, inspect cmdline for agent script paths.
    case "$comm" in
        node|bun)
            cmdline=$(tr '\0' ' ' < /proc/$pid/cmdline 2>/dev/null) || cmdline=""
            for agent in $KNOWN_AGENTS; do
                case "$cmdline" in
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
