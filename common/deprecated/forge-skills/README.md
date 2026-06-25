# Forge Skills

A collection of specialized forge interaction skills for GitHub and Gitea.

## Overview

This directory contains focused skills for interacting with different code hosting platforms:

- **GitHub**: Use `/forge-github` for GitHub repositories, issues, pull requests, releases, or CI
- **Gitea**: Use `/forge-gitea` for Gitea repositories, issues, pull requests, releases, or CI
- **Router**: Use `/forge-interaction` to let the system choose the right skill automatically

## Skill Structure

Each forge-specific skill is designed with:

1. **Single Responsibility**: Handles only one forge type (GitHub or Gitea)
2. **Predictable Behavior**: Clear decision tree and completion criteria
3. **Complete Coverage**: All requested forge actions are supported
4. **Error Handling**: Specific guidance for missing tools or authentication

## Choosing the Right Skill

### Use `/forge-github` when:
- Working with GitHub repositories (`github.com` URLs)
- Using the `gh` CLI tool
- Interacting with GitHub-specific features (issues, PRs, releases, CI)

### Use `/forge-gitea` when:
- Working with Gitea repositories (`gitea.com` or self-hosted Gitea)
- Using the `tea` CLI tool  
- Interacting with Gitea-specific features (issues, PRs, releases, CI)

### Use `/forge-interaction` when:
- You're unsure which forge you're working with
- You want the system to automatically choose the right skill
- You prefer a unified interface that handles both platforms

## Skill Comparison

| Feature | GitHub Skill | Gitea Skill |
|---------|--------------|-------------|
| CLI Tool | `gh` | `tea` |
| Platform | GitHub | Gitea |
| Focus | GitHub-specific | Gitea-specific |
| Predictability | High | High |
| Maintenance | Isolated | Isolated |

## Usage Examples

```
# For GitHub work
/forge-github create an issue in this repo
/forge-github list pull requests
/forge-github check CI status
/forge-github publish a new release

# For Gitea work  
/forge-gitea create an issue in this repo
/forge-gitea list pull requests
/forge-gitea check CI status
/forge-gitea publish a new release

# Let the system decide
/forge-interaction create a PR for this feature
```

## Why Separate Skills?

1. **Predictability**: Each skill knows exactly one forge type
2. **Maintainability**: Changes to GitHub or Gitea logic stay isolated
3. **Clarity**: Users can see which forge a skill handles at a glance
4. **Testing**: Each skill can be tested independently
5. **Cognitive Load**: Users remember fewer skills and their specific purposes

## Related Skills

- `/forge-router` - High-level guidance for choosing the right forge skill
- `/forge-preferences` - Personal or project-specific forge configurations

## Next Steps

1. Choose the appropriate skill based on your forge platform
2. Ensure the required CLI tool (`gh` or `tea`) is installed
3. Configure authentication for your forge platform
4. Start with simple actions and build up to more complex workflows