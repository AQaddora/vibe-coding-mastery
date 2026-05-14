# Changelog

All notable changes to the Vibe Coding Mastery repo, skill suite, and course material.

The format roughly follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versions are dated rather than numbered — this is a living curriculum, not a product release.

## 2026-05-14 — Windows install paths added

### Added

- `docs/install.md` — full installation guide covering macOS, Linux, and Windows
- Windows paths documented: Git Bash (recommended), WSL2 (power users), pure PowerShell with copy-not-symlink fallback
- Troubleshooting section covering symlink edge cases, skill detection, and uninstall
- Main README Quick Start now links to the install doc for Windows users
- Docs index links to the new install guide

## 2026-05-13 — Initial public release

### Added

- **Repo scaffolding** — split into public ([`vibe-coding-mastery`](https://github.com/AQaddora/vibe-coding-mastery)) and private (`vibe-coding-mastery-private`) repos with strict gitignore separation
- **Session 1 (free)** — slides (PowerPoint + PDF), live walkthrough, 60-minute assignment, references, terminology sheet
- **Skill: `doctrine-keeper`** (✅ final) — captures rules to `~/ai-doctrine.md`, syncs into every AI tool's config
- **Skill skeletons** — `prime`, `understand`, `refine`, `execute`, `organize-agents`, `pure-orchestrator` (structure + descriptions + protocols, scripts being built)
- **Master installer** — `skills/install.sh` bootstraps the doctrine, installs all 7 skills, optionally wires into a project
- **Templates** — `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `copilot-instructions.md`
- **Cross-tool sync** — `sync_to_agents.sh` symlinks the doctrine into Claude Code, Cursor (legacy + modern), Copilot, Codex/Gemini, and Windsurf
- **Tooling stubs** — `tools/new-session.sh` (session scaffolder), `tools/build-slides/` (placeholder)
- **GitHub workflows** — basic CI for shellcheck + python lint
- **Docs** — README, pricing placeholder, FAQ, this changelog

### Coming next

- Sessions 2–5 production (defense, MVP, SaaS, career)
- Logic implementation for the 6 skill skeletons
- Arabic slide translations
- Landing page + sales funnel at [aqaddoura.com/precourse](https://aqaddoura.com)

---

[← Documentation index](index.md) · [Repo root](../README.md)
