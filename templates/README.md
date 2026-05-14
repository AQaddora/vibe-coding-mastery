# Templates

Per-tool configuration templates that wire your `~/ai-doctrine.md` into every AI coding tool you use.

You don't usually need to copy these by hand — `skills/install.sh` (or `skills/doctrine-keeper/scripts/sync_to_agents.sh`) handles it. These files exist so you can read them, understand what gets installed, and customize them before deploying to a project.

## What's here

| File | Used by | What it does |
| --- | --- | --- |
| `CLAUDE.md` | Claude Code | Operating instructions Claude Code reads on every session |
| `AGENTS.md` | Codex, OpenAI Apps SDK, Gemini CLI | Generic agent instructions consumed by multiple OpenAI-style tools |
| `.cursorrules` | Cursor | Project rules loaded by Cursor on open |
| `copilot-instructions.md` | GitHub Copilot | Repo-level instructions for Copilot |

## How the memory bus uses them

The `doctrine-keeper` skill's `sync_to_agents.sh` script doesn't copy these templates verbatim into a project. Instead it **symlinks** the user's actual `~/ai-doctrine.md` into the standard locations each tool expects:

```
~/ai-doctrine.md          ←  single source of truth
        │
        ├── symlinked → <project>/CLAUDE.md
        ├── symlinked → <project>/AGENTS.md
        ├── symlinked → <project>/.cursorrules
        ├── symlinked → <project>/.cursor/rules/doctrine.mdc
        ├── symlinked → <project>/.github/copilot-instructions.md
        └── symlinked → <project>/.windsurfrules
```

The templates here are useful for two things:

1. **Reference** — read them to understand what each tool expects and what good defaults look like.
2. **Customization** — copy one into a project, modify the static sections (stack, style, hard rules), and append `cat ~/ai-doctrine.md` to it at deploy time if you want the rules embedded rather than symlinked.

## Customizing a template for your project

If you'd rather embed your doctrine into a tool's config file instead of symlinking (useful when committing the rules with the repo so collaborators use them too):

```bash
# Pick a template
cp templates/CLAUDE.md /path/to/project/CLAUDE.md

# Edit the stack/style/threat-model placeholders to match the project

# Append your doctrine rules so they ship with the project
echo "" >> /path/to/project/CLAUDE.md
echo "## Doctrine Rules" >> /path/to/project/CLAUDE.md
cat ~/ai-doctrine.md >> /path/to/project/CLAUDE.md
```

For solo work, symlinks are faster (rules update everywhere when you save a new one). For team projects, embedding is cleaner (everyone gets the same rules in their checkout without running `sync_to_agents.sh`).

---

[← Skills](../skills/README.md) · [Repo root](../README.md)
