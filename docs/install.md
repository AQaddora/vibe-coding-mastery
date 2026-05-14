# Installation

The PURE + AI Doctrine skill suite runs on macOS, Linux, and Windows. Pick the path that matches your machine.

## What gets installed

1. `~/ai-doctrine.md` — your personal AI rulebook (single source of truth)
2. All 7 skills symlinked into `~/.claude/skills/` (read automatically by Claude desktop / claude.ai / Claude Code)
3. Optional — per-project symlinks into Cursor, Copilot, Codex, Gemini CLI, and Windsurf config locations so every AI tool reads the same doctrine

Whichever OS you're on, the **end state** is identical — only the install steps differ.

---

## macOS / Linux

### Prerequisites

- Python 3.10+ (`python3 --version`)
- Git
- Bash (the default shell on macOS Ventura+ is zsh, but the installer is a bash script — it runs fine because `#!/usr/bin/env bash` invokes bash regardless)

If you don't have them:

```bash
# macOS (with Homebrew)
brew install python3 git

# Ubuntu / Debian
sudo apt update && sudo apt install -y python3 git

# Fedora
sudo dnf install -y python3 git
```

### Install

```bash
cd ~
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./skills/install.sh
```

You'll be asked whether to wire the doctrine into a project. Answer `n` for the install dir itself, then run sync separately on real projects:

```bash
cd ~/path/to/your/real/project
~/vibe-coding-mastery/skills/doctrine-keeper/scripts/sync_to_agents.sh
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

Expected output — 7 symlinks pointing to your clone:

```
doctrine-keeper -> /Users/you/vibe-coding-mastery/skills/doctrine-keeper
execute -> ...
organize-agents -> ...
prime -> ...
pure-orchestrator -> ...
refine -> ...
understand -> ...
```

Open Claude (desktop or claude.ai) and type:

```
add to doctrine: test rule — install works
```

If the `doctrine-keeper` skill triggers and adds an entry to `~/ai-doctrine.md`, you're live.

---

## Windows

Three paths. Pick the one that fits your setup.

### Path A — Git Bash (recommended for most Windows devs)

This is the smoothest path if you already have Git for Windows installed (most devs do).

#### Prerequisites

Install Python, Git, and enable Developer Mode (required for symlinks without admin elevation):

```powershell
# PowerShell as Administrator — one-time setup
winget install --id Git.Git
winget install --id Python.Python.3.12

# Enable Developer Mode (allows non-admin symlink creation)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
```

Restart your machine after enabling Developer Mode (don't skip the reboot — symlink permissions won't take effect otherwise).

#### Install

Open **Git Bash** (search for it in the Start menu — comes with Git for Windows). Not PowerShell. Not CMD.

```bash
# Tell Git Bash to make real Windows symlinks instead of placeholder files
export MSYS=winsymlinks:nativestrict

# Persist the setting for future sessions
echo 'export MSYS=winsymlinks:nativestrict' >> ~/.bashrc

# Clone + install
cd ~
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./skills/install.sh
```

In Git Bash, `~` maps to `C:\Users\<you>` — the same folder Claude desktop reads.

#### Wire doctrine into a project

```bash
cd /c/Users/you/path/to/project       # note Git Bash drive syntax
~/vibe-coding-mastery/skills/doctrine-keeper/scripts/sync_to_agents.sh
```

#### Verify

```bash
ls -la ~/.claude/skills/
```

All 7 entries should show as symlinks (`->`). If they show as regular files, the `MSYS=winsymlinks:nativestrict` setting didn't take — restart Git Bash and rerun the installer.

---

### Path B — WSL2 (power users / closer-to-Linux experience)

If you'd rather have a real Linux environment on Windows.

#### Install WSL2

```powershell
# PowerShell as Administrator — one-time setup
wsl --install -d Ubuntu
```

Reboot when prompted. After reboot, Ubuntu launches automatically — set a Linux username and password.

#### Install in WSL

```bash
sudo apt update && sudo apt install -y python3 git
cd ~
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./skills/install.sh
```

#### ⚠️ WSL location gotcha

Claude desktop on Windows reads `C:\Users\<you>\.claude\skills\`, but WSL's `~/.claude/skills/` is inside the Linux filesystem (`\\wsl$\Ubuntu\home\<you>\.claude\skills\`). They're different folders.

Two fixes — pick one:

**Option 1 — Use Claude Code inside WSL (recommended for WSL users):**

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Claude Code now runs inside WSL, reads WSL's `~/.claude/skills/`, and everything works identically to macOS.

**Option 2 — Install skills to the Windows side from WSL:**

```bash
# Discover Windows user home
WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n')
WIN_HOME="/mnt/c/Users/$WIN_USER"

# Make Claude skills dir on Windows side
mkdir -p "$WIN_HOME/.claude/skills"

# Symlink each skill from WSL repo into Windows user folder
for skill in doctrine-keeper prime understand refine execute organize-agents pure-orchestrator; do
    ln -sf "$PWD/skills/$skill" "$WIN_HOME/.claude/skills/$skill"
done

# Doctrine also lives on Windows side
python3 skills/doctrine-keeper/scripts/bootstrap.py --path "$WIN_HOME/ai-doctrine.md"
```

Claude desktop on Windows now reads the WSL-managed skills + doctrine.

---

### Path C — Pure PowerShell + copy-not-symlink (last resort)

Use this only if you can't enable Developer Mode (locked-down corporate machine) and can't install WSL.

```powershell
# In PowerShell — clone the repo
cd ~
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery

# Bootstrap doctrine
python skills\doctrine-keeper\scripts\bootstrap.py

# Copy each skill into Claude's folder (no symlinks)
$src = "$PWD\skills"
$dst = "$env:USERPROFILE\.claude\skills"
New-Item -ItemType Directory -Force -Path $dst | Out-Null
foreach ($skill in @("doctrine-keeper","prime","understand","refine","execute","organize-agents","pure-orchestrator")) {
    Copy-Item -Recurse -Force "$src\$skill" $dst
}

# Wire doctrine into a project (copy, not symlink)
$proj = "C:\Users\$env:USERNAME\path\to\your\project"
Copy-Item "$env:USERPROFILE\ai-doctrine.md" "$proj\CLAUDE.md"
Copy-Item "$env:USERPROFILE\ai-doctrine.md" "$proj\AGENTS.md"
Copy-Item "$env:USERPROFILE\ai-doctrine.md" "$proj\.cursorrules"
New-Item -ItemType Directory -Force -Path "$proj\.github" | Out-Null
Copy-Item "$env:USERPROFILE\ai-doctrine.md" "$proj\.github\copilot-instructions.md"
```

#### Trade-off you accept with this path

Copies don't stay synced. Every time you add a rule to `~/ai-doctrine.md`, you have to re-run the copy commands or your project tools will read stale rules. The symlink paths (A and B) are strictly better — fix Developer Mode if you can.

A simple resync helper to keep handy:

```powershell
# Save as: $env:USERPROFILE\resync-doctrine.ps1
$src = "$env:USERPROFILE\ai-doctrine.md"
$projects = @(
    "C:\Users\$env:USERNAME\path\to\project1",
    "C:\Users\$env:USERNAME\path\to\project2"
)
foreach ($p in $projects) {
    Copy-Item $src "$p\CLAUDE.md" -Force
    Copy-Item $src "$p\AGENTS.md" -Force
    Copy-Item $src "$p\.cursorrules" -Force
    Copy-Item $src "$p\.github\copilot-instructions.md" -Force
}
Write-Host "Doctrine synced to $($projects.Count) projects."
```

Run `powershell ~\resync-doctrine.ps1` after editing your doctrine.

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
5. The rule counter at the top of the file increments to 1

If any step fails, jump to [Troubleshooting](#troubleshooting).

## Troubleshooting

### "Skill not triggering"

Verify the skill exists and has valid YAML frontmatter:

```bash
# macOS / Linux / Git Bash / WSL
head -5 ~/.claude/skills/doctrine-keeper/SKILL.md

# PowerShell
Get-Content "$env:USERPROFILE\.claude\skills\doctrine-keeper\SKILL.md" -Head 5
```

First 4 lines should be:

```
---
name: doctrine-keeper
description: ...
license: MIT
```

If anything looks off, re-run the installer.

### "Symlinks show as regular files on Windows"

You forgot to:
1. Enable Developer Mode + reboot, or
2. Set `MSYS=winsymlinks:nativestrict` before running the installer

Fix both, then re-run `./skills/install.sh`.

### "Python not found"

```bash
# macOS
brew install python3

# Ubuntu / Debian / WSL
sudo apt install -y python3

# Windows
winget install --id Python.Python.3.12
```

### "sync_to_agents.sh symlinks point to a missing target"

Your `~/ai-doctrine.md` was deleted or moved. Re-bootstrap:

```bash
python3 ~/.claude/skills/doctrine-keeper/scripts/bootstrap.py --force
```

Then re-run `sync_to_agents.sh` in each affected project.

### "Claude desktop doesn't see my skills"

Restart Claude desktop after install — it scans `~/.claude/skills/` at startup. New installs after launch may not be visible until next restart.

### "I want to uninstall"

```bash
# macOS / Linux
rm -rf ~/.claude/skills/{doctrine-keeper,prime,understand,refine,execute,organize-agents,pure-orchestrator}
# Optional — keep your doctrine, just remove the skills:
# (do nothing extra)
# Or — wipe everything:
rm -f ~/ai-doctrine.md

# Windows PowerShell
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\doctrine-keeper",`
    "$env:USERPROFILE\.claude\skills\prime",`
    "$env:USERPROFILE\.claude\skills\understand",`
    "$env:USERPROFILE\.claude\skills\refine",`
    "$env:USERPROFILE\.claude\skills\execute",`
    "$env:USERPROFILE\.claude\skills\organize-agents",`
    "$env:USERPROFILE\.claude\skills\pure-orchestrator"
```

The clone of the repo can be deleted normally — `rm -rf vibe-coding-mastery` / `Remove-Item -Recurse -Force vibe-coding-mastery`.

---

## After install — what to do first

Continue to the [Quick start in the main README](../README.md#quick-start), or jump straight to the 7 trigger phrases your daily workflow lives on.

---

[← Documentation index](index.md) · [Repo root](../README.md)
