# Changelog

All notable changes to the Vibe Coding Mastery repo, skill suite, and course material.

The format roughly follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versions are dated rather than numbered — this is a living curriculum, not a product release.

## 2026-05-27 — Skills extracted to their own repo

### Changed

- The 8 PURE + AI Doctrine skills now live in their own dedicated repo:
  [**AQaddora/pure-skill-suite**](https://github.com/AQaddora/pure-skill-suite).
  This course repo no longer duplicates the skill source — it ships an
  `install.sh` shim at the root that clones `pure-skill-suite` as a sibling
  directory and delegates to its installer.
- Quick-start command changed from `./skills/install.sh` to `./install.sh`.
- README, docs/install.md, docs/faq.md, docs/index.md, and CONTRIBUTING.md
  updated to reflect the split.

### Removed

- `skills/` directory deleted from this repo (entire content moved to
  the suite repo).
- `LICENSE` no longer lists `skills/` under the MIT section (it's now
  MIT-licensed in the suite repo, which carries its own LICENSE).

### Why

The skills and the courseware were always two products in one repo:
the skills are a tool you install and use daily across every codebase;
the courseware is content you read once and apply. Bundling them meant
every skill update required a course-repo commit, and external users
who only wanted the skills had to clone the entire course (with all
its session material) just to run the installer. The split gives both
products clean ownership: the suite ships independently, the course
references it.

### Migration for existing users

If you previously cloned `vibe-coding-mastery` and ran `./skills/install.sh`:

```bash
cd ~/vibe-coding-mastery
git pull
./install.sh                # clones pure-skill-suite alongside, idempotent re-install
```

Your existing `~/ai-doctrine.md` and `~/.claude/skills/*` are preserved.
The installer re-points the symlinks to `~/pure-skill-suite/skills/<name>/`
on this run.

## 2026-05-14 — Series naming locked: "Vibe Coding Mastery — Mindset Foundations"

### Added

- **Series title locked:** `Vibe Coding Mastery — Mindset Foundations`. This is the first tier of the multi-tier Vibe Coding Mastery program.
- Main README hero, sessions intro, all 5 session READMEs now carry the series identity (`Vibe Coding Mastery — Mindset Foundations (Session N of 5)`).
- Docs index intro updated.
- FAQ gained a new "What's in the more advanced tiers?" Q&A.
- docs/pricing.md updated to explain the multi-tier framing — Foundations is free, future tiers will be priced honestly when ready.

### Strategic frame

The brand is **Vibe Coding Mastery**. The free 5-session series is the **Mindset Foundations** tier. More advanced tiers will follow under the same Mastery brand — they don't exist yet, so they're not promoted yet.

## 2026-05-14 — Positioning reset: everything is free, no paid bundle

### Changed

- **All 5 sessions are now free.** Previously framed as "Session 1 free + Sessions 2–5 paid bundle." That framing is gone. The mindset series is a give to the developer community, full stop.
- **No pricing page.** `docs/pricing.md` rewritten to explain why there's no pricing — it's a free repo.
- **Future paid program de-emphasized.** The longer paid Vibe Coding Mastery program is in production but not promoted yet — it'll be announced when ready. Removed forward-looking mentions from the README, FAQ, Session 5, and the private repo README.
- **LICENSE softened.** The session content stays copyright-protected against republishing/rebranding, but the framing now leads with what readers *may* do freely (read, share, quote, apply, build, earn) rather than what's restricted.
- **FAQ rewritten.** Replaced "free preview vs paid course" Q&As with clear "everything is free" answers.
- **Session READMEs cleaned.** Sessions 2–5 placeholders no longer say "Cost: Paid". Session 1 README removed its "Why this is free" section (it's the wrong frame now — every session is free).
- **Sessions README updated.** Removed lead-magnet framing; described as a free mindset series, period.

### Why

This isn't a sales funnel. It's a mindset share. The skill suite has always been MIT-licensed and freely installable. Now the session content matches that posture.

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
