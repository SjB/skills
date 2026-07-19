# TMUX Launch Agent — Agent CLI Seed Data

## Agents

```yaml
agents:
  - name: pi
    binary: pi
    args: "@{prompt}"
    modelflag: "--model"
    description: "My primary agent harness. Accepts prompt file via {prompt}."

  - name: opencode
    binary: opencode
    args: ""
    modelflag: "-m"
    description: "OpenCode agent. Pipes stdin via cat."
    note: "Uses stdin piping: args must be empty, prompt via pipe."

  - name: goose
    binary: goose
    args: ""
    modelflag: "--model"
    description: "Goose agent. Accepts prompt file via -i flag."
    note: "Uses stdin piping: args must be empty, prompt via pipe."

  - name: codex
    binary: codex
    args: "@{prompt}"
    modelflag: "-m"
    description: "OpenAI Codex. Accepts prompt file via {prompt}."

  - name: claude
    binary: claude
    args: ""
    modelflag: "--model"
    description: "Anthropic Claude CLI. Pipes stdin via cat."
    note: "Uses stdin piping: args must be empty, prompt via pipe."
```

## Field meanings

| Field | Description |
| ------- | ------------- |
| `name` | Display name used in menus and `--agent` flag |
| `binary` | Command name expected on PATH |
| `args` | Static arguments appended after the binary. May include `{prompt}` which is substituted at invocation time with the absolute path to the prompt file. Empty string means stdin piping (prompt is piped via `cat`). |
| `description` | Short human-readable description for the setup menu |
| `modelflag` | CLI flag used to select a model (e.g. `--model`, `-m`). Injected into the inner command when `--model <name>` is passed by the user. |
| `note` | Optional additional context |
