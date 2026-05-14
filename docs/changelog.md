# Changelog

All notable changes to the Vibe Coding Mastery repo, skill suite, and course material.

The format roughly follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versions are dated rather than numbered — this is a living curriculum, not a product release.

## 2026-05-14 — Handoff skill added (8th skill)

### Added

- **New skill: `handoff`** — formalizes the context-window evacuation technique Ahmed has been using manually. Produces a copy-pasteable Markdown handoff block that migrates a long AI coding session to a fresh chat without losing state.
- Handoff trigger phrases: "handoff this", "we're running out of context", "fresh chat for this", "this is getting heavy", "prepare a handoff"
- AI-driven proactive detection — when the orchestrator (or any skill) notices ~40+ turns, >10 files read, or scope drift, it suggests a handoff and waits for user approval before producing the block
- `references/handoff-format.md` — canonical handoff block template with annotated example and anti-patterns
- **pure-orchestrator updated** — context-pressure gate between Phase 1 (Prime) and Phase 2 (Understand). Handoff fires after Prime completes so the new chat boots loaded.
- `skills/install.sh` updated to install 8 skills (was 7)
- Main README, skills README, and CI structural check all bumped to 8 skills
- Architecture diagram in skills/README updated to show the context-pressure gate

### Why this matters

The handoff technique is what bootstrapped this entire repo — the original cowork session that built the public + private repos started from a single handoff block in a fresh Claude chat. Until now it was an informal practice Ahmed used by hand. The skill formalizes it as part of the standard PURE discipline.

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
