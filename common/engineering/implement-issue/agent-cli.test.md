# Agent CLI Tests for implement-issue

These tests verify the tmux command composition logic in `implement-issue`. They intercept the generated shell command string rather than the tmux invocation itself.

The seam being tested: given a `docs/agents/agent-cli.md` config and a `mise` availability state, `implement-issue` must compose the correct tmux launch command.

## Test fixtures

### Fixture: pi agent config (stdin-piped via @{prompt})

```yaml
# docs/agents/agent-cli.md
selected: pi
binary: pi
args: "-p @{prompt}"
```

### Fixture: opencode agent config

```yaml
# docs/agents/agent-cli.md
selected: opencode
binary: opencode
args: "run -f @{prompt}"
```

### Fixture: codex agent config (empty args = stdin pipe)

```yaml
# docs/agents/agent-cli.md
selected: codex
binary: codex
args: ""
```

### Fixture: missing binary config

```yaml
# docs/agents/agent-cli.md
selected: missing-agent
binary: totally-not-on-path
args: ""
```

## Test cases

### Test: composes correct tmux command for pi with mise available

**Given:**
- `docs/agents/agent-cli.md` contains the pi fixture
- `command -v mise` succeeds

**When:** `implement-issue` composes the tmux launch command

**Then:** the generated command string is:

```
tmux new-window -n "issue-42-ws-sjb-skills" -c /home/sjb/Projects/personal/ws-sjb-skills/ws-sjb-skills-issue-42 "mise x --allow-env='*' -- pi -p /tmp/issue-42-prompt.md"
```

**Notes:**
- `@{prompt}` is substituted with the actual temp file path
- Window name includes issue number and repo slug
- Worktree path is absolute
- `mise x --allow-env='*'` is prepended when mise is available

---

### Test: composes correct tmux command for pi without mise (fallback to $SHELL -c)

**Given:**
- `docs/agents/agent-cli.md` contains the pi fixture
- `command -v mise` fails (no mise on PATH)

**When:** `implement-issue` composes the tmux launch command

**Then:** the generated command string is:

```
tmux new-window -n "issue-42-ws-sjb-skills" -c /home/sjb/Projects/personal/ws-sjb-skills/ws-sjb-skills-issue-42 "$SHELL -c 'pi -p /tmp/issue-42-prompt.md'"
```

**Notes:**
- Falls back to `$SHELL -c` when mise is absent
- The agent command is wrapped inside `$SHELL -c '...'`

---

### Test: composes correct tmux command for codex (stdin piping, no @{prompt})

**Given:**
- `docs/agents/agent-cli.md` contains the codex fixture (args: "")
- `command -v mise` succeeds

**When:** `implement-issue` composes the tmux launch command

**Then:** the generated command string is:

```
tmux new-window -n "issue-42-ws-sjb-skills" -c /home/sjb/Projects/personal/ws-sjb-skills/ws-sjb-skills-issue-42 "mise x --allow-env='*' -- sh -c 'cat /tmp/issue-42-prompt.md | codex'"
```

**Notes:**
- When args is empty, prompt is piped via `cat <prompt> | <binary>`
- The pipe syntax is always `cat <prompt> | <binary>` for stdin-based agents

---

### Test: fails fast with clear message when binary not on PATH

**Given:**
- `docs/agents/agent-cli.md` contains the missing binary fixture
- `command -v totally-not-on-path` fails

**When:** `implement-issue` validates the binary at invocation time

**Then:** it fails immediately with:

```
Agent 'totally-not-on-path' not found on PATH — rerun /setup-skills to reconfigure.
```

**Notes:**
- Validation happens before any tmux launch
- Error message directs user to re-run setup-skills

---

### Test: reads selected agent from docs/agents/agent-cli.md

**Given:**
- `docs/agents/agent-cli.md` exists and contains valid YAML with `selected`, `binary`, and `args` fields

**When:** `implement-issue` reads the config at invocation time

**Then:** it parses the three fields correctly and uses them for dispatch

**Notes:**
- Does not use hardcoded dispatch table
- Does not run detection scripts
- Reads directly from the repo-side config file

---

### Test: @{prompt} placeholder substitution

**Given:**
- `docs/agents/agent-cli.md` contains opencode fixture (args: "run -f @{prompt}")
- `command -v mise` succeeds

**When:** `implement-issue` composes the tmux launch command with prompt file at `/tmp/issue-99-prompt.md`

**Then:** the generated command contains:

```
opencode run -f /tmp/issue-99-prompt.md
```

**Notes:**
- `@{prompt}` in args is replaced with the absolute path to the temp prompt file
- Works regardless of where `@{prompt}` appears in the args string