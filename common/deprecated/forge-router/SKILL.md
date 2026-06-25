---
name: forge-router
disable-model-invocation: true
---

# Forge Router

Choose the right forge interaction skill for your task.

## When to use:

- **GitHub**: Use `/forge-github` when working with GitHub repositories, issues, pull requests, releases, or CI.
- **Gitea**: Use `/forge-gitea` when working with Gitea repositories, issues, pull requests, releases, or CI.

## How it works:

The router delegates to specialized skills that handle each forge type separately. This keeps each skill focused and predictable.

**GitHub skill** (`/forge-github`):
- Handles GitHub-specific interactions using the `gh` CLI
- Follows GitHub's API patterns and conventions
- Optimized for GitHub's feature set

**Gitea skill** (`/forge-gitea`):
- Handles Gitea-specific interactions using the `tea` CLI  
- Follows Gitea's API patterns and conventions
- Optimized for Gitea's feature set

## Why separate:

- **Predictability**: Each skill knows exactly one forge type
- **Maintainability**: Changes to GitHub or Gitea logic stay isolated
- **Clarity**: Users can see which forge a skill handles at a glance
- **Testing**: Each skill can be tested independently

## Usage examples:

```
# For GitHub work
/forge-github create an issue in this repo
/forge-github list pull requests
/forge-github check CI status

# For Gitea work  
/forge-gitea create an issue in this repo
/forge-gitea list pull requests
/forge-gitea check CI status
```

The router ensures you always use the right tool for the right forge.