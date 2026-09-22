# Mise integration

This machine uses mise for dotfile management and development tools.

## Sources of truth

- `$DOTFILES_ROOT/mise.toml` — dotfiles, bootstrap packages, setup tasks.
- `$DOTFILES_ROOT/config/mise/config.toml` — mise tools and tasks.
- `$DOTFILES_ROOT/packages/sjb-dev.packages` — pacman development packages.

Prefer the configured owner: a tool in mise `[tools]` is reconciled with `mise install`; a package in `sjb-dev.packages` is checked with pacman. Duplicate installations are reported, never removed.

## Read-only commands

Run from the dotfiles root after verifying it contains `mise.toml`:

```bash
mise ls          # installed tools
mise outdated    # tools behind their declared version
mise tasks       # list tasks
```

## Mutations (approval required)

```bash
mise install     # reconcile declared tools — network + installs
mise run <task>  # runs project tasks — may install plugins, edit config, enable services
mise trust       # approve a config's executable settings — approve once, explicitly
```

Never run all tasks as a bundle; each needs its own approval. Never trust an arbitrary discovered project automatically.

## Shell activation

Bash and Fish configuration activate mise. When a mise-managed command is missing, check shell activation and `mise ls` before installing another copy.
