# Agent CLI Seed Data

This file is the source of truth for all supported CLI agents. It is read by `setup-skills` Section E to present the menu and by `implement-issue` for agent dispatch.

## Agents

```yaml
agents:
  - name: pi
    binary: pi
    args: "-p @{prompt}"
    description: "My primary agent harness. Accepts prompt file via -p flag."

  - name: opencode
    binary: opencode
    args: "run -f @{prompt}"
    description: "OpenCode agent. Accepts prompt file via -f flag."

  - name: goose
    binary: goose
    args: "run -i @{prompt}"
    description: "Goose agent. Accepts prompt file via -i flag."

  - name: codex
    binary: codex
    args: ""
    description: "OpenAI Codex. Pipes stdin via cat."
    note: "Uses stdin piping: args must be empty, prompt via pipe."

  - name: claude
    binary: claude
    args: "-p"
    description: "Anthropic Claude CLI. Pipes stdin via cat."
    note: "Uses stdin piping: args is just the prompt flag, prompt via pipe."
```

## Field meanings

| Field | Description |
|-------|-------------|
| `name` | Display name used in menus and `--agent` flag |
| `binary` | Command name expected on PATH |
| `args` | Static arguments appended after the binary. May include `@{prompt}` which is substituted at invocation time with the absolute path to the prompt file. Empty string means stdin piping (prompt is piped via `cat`). |
| `description` | Short human-readable description for the setup menu |
| `note` | Optional additional context |