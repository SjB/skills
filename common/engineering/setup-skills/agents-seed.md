# Agent CLI Seed Data

This file is the source of truth for all supported CLI agents. It is read by `setup-skills` Section E to present the menu and by `implement-issue` for agent dispatch.

## Agents

```yaml
agents:
  - name: pi
    binary: pi
    args: "@{prompt}"
    description: "My primary agent harness. Accepts prompt file via {prompt}."

  - name: opencode
    binary: opencode
    args: ""
    description: "OpenCode agent. Pipes stdin via cat."
    note: "Uses stdin piping: args must be empty, prompt via pipe."

  - name: goose
    binary: goose
    args: ""
    description: "Goose agent. Accepts prompt file via -i flag."
    note: "Uses stdin piping: args must be empty, prompt via pipe."

  - name: codex
    binary: codex
    args: "@{prompt}"
    description: "OpenAI Codex. Accepts prompt file via {prompt}."

  - name: claude
    binary: claude
    args: ""
    description: "Anthropic Claude CLI. Pipes stdin via cat."
    note: "Uses stdin piping: args must be empty, prompt via pipe."
```

## Field meanings

| Field | Description |
|-------|-------------|
| `name` | Display name used in menus and `--agent` flag |
| `binary` | Command name expected on PATH |
| `args` | Static arguments appended after the binary. May include `{prompt}` which is substituted at invocation time with the absolute path to the prompt file. Empty string means stdin piping (prompt is piped via `cat`). |
| `description` | Short human-readable description for the setup menu |
| `note` | Optional additional context |
