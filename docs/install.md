# Installation

The vibe-coding-mastery installer is a thin shim around the [**PURE Skill Suite**](https://github.com/AQaddora/pure-skill-suite) installer. The skills live in their own repo so they can be installed and updated independently of the courseware.

## What gets installed

1. `~/ai-doctrine.md` — your personal AI rulebook (single source of truth)
2. All 8 skills symlinked into `~/.claude/skills/` (read automatically by Claude desktop / claude.ai / Claude Code)
3. Optional — per-project symlinks into Cursor, Copilot, Codex, Gemini CLI, and Windsurf config locations so every AI tool reads the same doctrine

The skill suite is cloned as a **sibling directory** to `vibe-coding-mastery`. Override with `SUITE_DIR=<path>` if you want it somewhere else.

---

## macOS / Linux

```bash
cd ~
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./install.sh
```

That's it. `./install.sh` will:

1. Clone `pure-skill-suite` to `~/pure-skill-suite/` (or update it if already present)
2. Run the suite's installer, which creates `~/ai-doctrine.md` + symlinks the 8 skills into `~/.claude/skills/`
3. Ask whether to wire the doctrine into your current project (answer `n` for the install dir; sync separately on real projects)

To wire a real project later:

```bash
cd ~/path/to/your/real/project
~/pure-skill-suite/skills/doctrine-keeper/scripts/sync_to_agents.sh
```

### Fill in your default primer

```bash
open ~/ai-doctrine.md       # macOS
xdg-open ~/ai-doctrine.md   # Linux
```

Find `## My Default Primer` and replace the placeholders with your real stack, style, threat model, and audience.

### Verify

```bash
ls -la ~/.claude/skills/
```

Expected — 8 symlinks pointing to your pure-skill-suite clone:

```
doctrine-keeper  -> /Users/you/pure-skill-suite/skills/doctrine-keeper
execute          -> ...
handoff          -> ...
organize-agents  -> ...
prime            -> ...
pure-orchestrator-> ...
refine           -> ...
understand       -> ...
```

Open Claude (desktop or claude.ai) and type:

```
add to doctrine: test rule — install works
```

If `doctrine-keeper` triggers and adds an entry to `~/ai-doctrine.md`, you're live.

---

## Windows

The course's `./install.sh` shim runs in **Git Bash** or **WSL2** — both ship the bash interpreter the installer needs.

### Path A — Git Bash (recommended)

```bash
# In Git Bash. Required setup: see https://github.com/AQaddora/pure-skill-suite#windows
export MSYS=winsymlinks:nativestrict
cd ~
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./install.sh
```

### Path B — WSL2

```bash
sudo apt update && sudo apt install -y python3 git
cd ~
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./install.sh
```

### Path C — Pure PowerShell (no bash)

The vibe-coding-mastery shim is bash-only. For pure PowerShell installs, use the [pure-skill-suite Windows guide](https://github.com/AQaddora/pure-skill-suite#windows) directly — it includes a PowerShell-only path. Once skills are installed, return here for the courseware.

### Windows prerequisites + WSL gotchas

Symlink permissions, the WSL ↔ Windows `.claude/` location split, and the PowerShell fallback all live in [pure-skill-suite's install docs](https://github.com/AQaddora/pure-skill-suite#windows) so the playbook stays in one place.

---

## Verify (any OS)

Open Claude (desktop, claude.ai, or Claude Code) in a fresh conversation and type:

```
add to doctrine: test rule — install successful
```

What should happen:

1. The `doctrine-keeper` skill triggers (Claude announces it)
2. Claude proposes a formatted entry
3. You approve
4. A new entry appears at the bottom of `~/ai-doctrine.md` (or `C:\Users\you\ai-doctrine.md` on Windows)
5. The rule counter at the top of the file increments

If any step fails, jump to [Troubleshooting](#troubleshooting).

## Troubleshooting

### "Skill not triggering"

Verify the skill is symlinked under `~/.claude/skills/` and has valid YAML frontmatter:

```bash
head -5 ~/.claude/skills/doctrine-keeper/SKILL.md
```

First 4 lines should be:

```
---
name: doctrine-keeper
description: ...
license: MIT
```

If anything looks off, re-run `./install.sh` from the vibe-coding-mastery clone. The suite installer is idempotent — safe to re-run.

### "I already cloned pure-skill-suite somewhere else"

```bash
SUITE_DIR=/path/to/your/existing/pure-skill-suite ./install.sh
```

The shim will update that clone instead of creating a new sibling.

### Everything else

The skill-install details (Windows symlinks, Python paths, sync_to_agents.sh quirks, uninstall, etc.) all live in [pure-skill-suite's docs](https://github.com/AQaddora/pure-skill-suite). The vibe-coding-mastery shim doesn't introduce its own failure modes — anything that breaks happens inside the suite installer.

---

## After install — what to do next

Continue to the [Quick start in the main README](../README.md#quick-start), or jump straight into [Session 1: The AI-First Developer Mindset](../sessions/session-01-mindset/README.md).

---

[← Documentation index](index.md) · [Repo root](../README.md) · [Skill suite repo](https://github.com/AQaddora/pure-skill-suite)
