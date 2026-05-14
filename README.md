# Vibe Coding Mastery

> **The PURE Loop + AI Doctrine — a cross-tool memory and operating system for developers using AI.**
>
> By [Ahmed Qaddoura](https://aqaddoura.com) · Palestine

[![License: MIT (skills)](https://img.shields.io/badge/skills-MIT-green)](LICENSE) [![Course: ARR](https://img.shields.io/badge/course-all%20rights%20reserved-blue)](LICENSE) [![Made in Palestine](https://img.shields.io/badge/made%20in-Palestine-success)](https://aqaddoura.com)

---

## The 30-second pitch

Most developers using AI in 2026 are still operating like it's 2023 — they type a prompt, copy the answer, ship the code, and forget what they learned. Six months in, they can't remember why their own codebase exists.

This repo is the *operating system* the top 5% use instead.

It gives you:

1. **A 4-phase loop** — **P**rime → **U**nderstand → **R**efine → **E**xecute — that turns any AI session into a senior-pair experience instead of fancy autocomplete.
2. **A personal AI Doctrine** — `~/ai-doctrine.md`, a single file on your machine that captures every hard-won rule and is symlinked into Claude, Cursor, Copilot, Codex, Gemini CLI, and Windsurf so the same memory follows you across every tool.
3. **Eight skills** that make both of the above automatic in Claude (and any agent that reads the doctrine), including a **handoff** skill that cleanly migrates long sessions to fresh chats when context fills up.

The framework is invented and battle-tested in production. The skills are open source (MIT). The 5-session companion series that teaches the mindset is free, forever. This is a give, not a funnel.

## Quick start

**macOS / Linux:**

```bash
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./skills/install.sh
```

**Windows:** the installer runs on Git Bash, WSL2, or as a PowerShell-only fallback. Full step-by-step in [`docs/install.md`](docs/install.md).

The installer creates `~/ai-doctrine.md`, installs all 7 skills into `~/.claude/skills/`, and (optionally) wires the doctrine into your current project so every AI tool reads the same memory.

Once installed, open Claude and try one of:

```
"prime me for a FastAPI feature"
"run PURE on adding tenant audit logging"
"add to doctrine: always state Pydantic v2 in primer"
```

Open Cursor or Copilot in the same project — they pick up the same rules automatically.

## The 5 sessions

| # | Session | Status |
| --- | --- | --- |
| 1 | [The AI-First Developer Mindset](sessions/session-01-mindset/README.md) | ✅ Final |
| 2 | [Get the Best From AI Tools (Without Getting Burned)](sessions/session-02-defense/README.md) | ⏳ In production |
| 3 | [Ship Your MVP in a Weekend](sessions/session-03-mvp/README.md) | ⏳ In production |
| 4 | [Build Trusted SaaS — Security, UX & Margin From Day 1](sessions/session-04-saas/README.md) | ⏳ In production |
| 5 | [Automate Your Career & Build on the Side (Stress-Free)](sessions/session-05-career/README.md) | ⏳ In production |

All five sessions are **free**. Slides, practical walkthroughs, assignments, references — everything ships here as it's produced.

## The 8 skills

| # | Skill | What it does | Install path |
| --- | --- | --- | --- |
| 1 | [`doctrine-keeper`](skills/doctrine-keeper/SKILL.md) | The memory bus — captures every rule to `~/ai-doctrine.md` | `./skills/install.sh` |
| 2 | [`prime`](skills/prime/SKILL.md) | Builds the primer that loads before any real task | `./skills/install.sh` |
| 3 | [`understand`](skills/understand/SKILL.md) | Clarifies scope before code is written | `./skills/install.sh` |
| 4 | [`refine`](skills/refine/SKILL.md) | Senior-reviewer self-review on AI output | `./skills/install.sh` |
| 5 | [`execute`](skills/execute/SKILL.md) | Delegates work to a coding agent, tracks the run | `./skills/install.sh` |
| 6 | [`organize-agents`](skills/organize-agents/SKILL.md) | Registry of agent runs across every tool | `./skills/install.sh` |
| 7 | [`pure-orchestrator`](skills/pure-orchestrator/SKILL.md) | Runs the full P→U→R→E loop with checkpoints | `./skills/install.sh` |
| 8 | [`handoff`](skills/handoff/SKILL.md) | Migrates a long session to a fresh chat without losing state | `./skills/install.sh` |

All 8 are MIT licensed. The orchestrator pulls in the others.

## Cross-tool memory — how it works

```
        any AI coding session (Claude, Cursor, Copilot, Codex, Gemini, Aider)
                                    │
                            "save this rule"
                                    │
                                    ▼
                          ┌──────────────────┐
                          │  doctrine-keeper │
                          └────────┬─────────┘
                                   │ appends to
                                   ▼
                            ~/ai-doctrine.md   ← single source of truth
                                   │
                                   │ symlinked by sync_to_agents.sh
                  ┌────────────────┼────────────────┐
                  ▼                ▼                ▼
             CLAUDE.md       .cursorrules    .github/copilot-instructions.md
             AGENTS.md       .windsurfrules  .cursor/rules/doctrine.mdc
             (Codex /        (Windsurf)      (Copilot)
              Gemini CLI)
```

Save a rule once. Every AI tool you open in that project reads it. Switch from Claude to Cursor to Copilot — same memory, same standards, same primer.

This is the **invention** at the heart of this repo, and the reason it's not just another prompt-engineering side project.

## What's in this repo

```
vibe-coding-mastery/
├── README.md                  ← you are here
├── LICENSE                    ← MIT for skills, ARR for course content
├── CONTRIBUTING.md
│
├── sessions/                  ← course material
│   ├── session-01-mindset/    ← ✅ Free lead magnet
│   ├── session-02-defense/    ← ⏳ paid pre-course
│   ├── session-03-mvp/        ← ⏳ paid pre-course
│   ├── session-04-saas/       ← ⏳ paid pre-course
│   └── session-05-career/     ← ⏳ paid pre-course
│
├── skills/                    ← the 8 PURE + AI Doctrine skills (MIT)
│   ├── install.sh             ← one-shot installer
│   ├── doctrine-keeper/
│   ├── prime/
│   ├── understand/
│   ├── refine/
│   ├── execute/
│   ├── organize-agents/
│   ├── pure-orchestrator/
│   └── handoff/
│
├── templates/                 ← per-tool config templates (CLAUDE.md, etc.)
├── tools/                     ← session scaffolders + slide build helpers
├── docs/                      ← extended docs (pricing, FAQ, changelog)
└── .github/                   ← issue templates + CI
```

Private course materials (speaker scripts, teleprompter copy, role notes) live in a separate private repo: `github.com/AQaddora/vibe-coding-mastery-private`.

## About Ahmed

[Ahmed Qaddoura](https://aqaddoura.com) — software architect, builder, and instructor from Gaza, Palestine. Background spans game development (Unity), backend systems (Python/FastAPI/PostgreSQL), and work with the Palestine Innovation Initiative + Taqat Academy.

The PURE Loop + AI Doctrine framework is the system Ahmed runs in production daily. It's been pressure-tested across founder work, agency client builds, and teaching cohorts of Palestinian developers. The 5-session series here is the mindset behind it — shared free as a give to the developer community.

Connect:

- 🌐 [aqaddoura.com](https://aqaddoura.com)
- 🐙 [github.com/AQaddora](https://github.com/AQaddora)
- 💼 LinkedIn — [Ahmed Qaddoura](https://www.linkedin.com/in/aqaddora/)

## License

| What | License |
| --- | --- |
| Everything in `skills/`, `templates/`, `tools/`, `.github/` | **MIT** — use, fork, build on |
| Everything in `sessions/`, `docs/` | **Free to learn from. Copyright Ahmed Qaddoura — do not republish or repackage.** |
| The **PURE Loop** and **AI Doctrine** framework names | Credit when referencing — they're Ahmed's invention |

See [LICENSE](LICENSE) for the full text.

## Stay in the loop

📌 Mailing list: [aqaddoura.com](https://aqaddoura.com) — get a heads-up when Sessions 2–5 drop
📌 Star this repo on GitHub to follow along as content is added

---

```
// yalla — let's build.
```

*Vibe Coding Mastery · Palestine Innovation Initiative · Taqat Academy · Kawkab.ai · 2026*
