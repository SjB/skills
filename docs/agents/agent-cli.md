# Agent CLI Configuration

The CLI agent used by `/implement-issue` for spawning child agents in isolated git worktrees.

## Configuration

```yaml
selected: pi
binary: pi
args: "-p @{prompt}"
```

## Fields

| Field | Description |
|-------|-------------|
| `selected` | Display name of the selected agent |
| `binary` | Command name expected on PATH |
| `args` | Static arguments. `@{prompt}` is substituted with the prompt file path at invocation time. Empty means stdin piping via `cat`. |

## Changing the agent

Run `/setup-skills` Section E to reconfigure. The full list of supported agents is in `common/engineering/setup-skills/agents-seed.md`.