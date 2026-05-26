# Vibe Coding Mastery — Mindset Foundations

> **The PURE Loop + AI Doctrine — a cross-tool memory and operating system for developers using AI.**
>
> A free 5-part series + open-source skill suite. The **first tier** of the Vibe Coding Mastery program. More advanced tiers follow under the same Mastery brand.
>
> By [Ahmed Qaddoura](https://aqaddoura.com) · Palestine

[![Skills: MIT](https://img.shields.io/badge/skills-MIT-green)](LICENSE) [![Series: Free](https://img.shields.io/badge/series-free%20forever-success)](LICENSE) [![Made in Palestine](https://img.shields.io/badge/made%20in-Palestine-success)](https://aqaddoura.com)

---

## The 30-second pitch

Most developers using AI in 2026 are still operating like it's 2023 — they type a prompt, copy the answer, ship the code, and forget what they learned. Six months in, they can't remember why their own codebase exists.

This repo is the *operating system* the top 5% use instead — the **Mindset Foundations** tier of the Vibe Coding Mastery program. Free, forever.

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
./install.sh
```

`./install.sh` is a shim that clones the [PURE Skill Suite](https://github.com/AQaddora/pure-skill-suite) as a sibling directory (skills live in their own repo so they can ship independently of the courseware) and runs its installer. One command, end-to-end.

**Windows:** the installer runs on Git Bash, WSL2, or as a PowerShell-only fallback. Full step-by-step in [`docs/install.md`](docs/install.md).

The installer creates `~/ai-doctrine.md`, installs all 8 skills into `~/.claude/skills/`, and (optionally) wires the doctrine into your current project so every AI tool reads the same memory.

Once installed, open Claude and try one of:

```
"prime me for a FastAPI feature"
"run PURE on adding tenant audit logging"
"add to doctrine: always state Pydantic v2 in primer"
```

Open Cursor or Copilot in the same project — they pick up the same rules automatically.

## The 5 sessions (Mindset Foundations tier)

| # | Session | Status |
| --- | --- | --- |
| 1 | [The AI-First Developer Mindset](sessions/session-01-mindset/README.md) | ✅ Final |
| 2 | [Get the Best From AI Tools (Without Getting Burned)](sessions/session-02-defense/README.md) | ⏳ In production |
| 3 | [Ship Your MVP in a Weekend](sessions/session-03-mvp/README.md) | ⏳ In production |
| 4 | [Build Trusted SaaS — Security, UX & Margin From Day 1](sessions/session-04-saas/README.md) | ⏳ In production |
| 5 | [Automate Your Career & Build on the Side (Stress-Free)](sessions/session-05-career/README.md) | ⏳ In production |

All five sessions are **free**. Slides, practical walkthroughs, assignments, references — everything ships here as it's produced. More advanced tiers (deeper builds, full-stack AI products, monetization) will follow under the same Vibe Coding Mastery program.

## The 8 skills (in a separate repo)

The skills live in [**AQaddora/pure-skill-suite**](https://github.com/AQaddora/pure-skill-suite) so they can be installed and consumed independently of this courseware:

| # | Skill | What it does |
| --- | --- | --- |
| 1 | [`doctrine-keeper`](https://github.com/AQaddora/pure-skill-suite#doctrine-keeper) | The memory bus — captures every rule to `~/ai-doctrine.md` |
| 2 | [`prime`](https://github.com/AQaddora/pure-skill-suite#prime) | Builds the primer that loads before any real task |
| 3 | [`understand`](https://github.com/AQaddora/pure-skill-suite#understand) | Clarifies scope before code is written |
| 4 | [`refine`](https://github.com/AQaddora/pure-skill-suite#refine) | Senior-reviewer self-review on AI output |
| 5 | [`execute`](https://github.com/AQaddora/pure-skill-suite#execute) | Delegates work to a coding agent, tracks the run |
| 6 | [`organize-agents`](https://github.com/AQaddora/pure-skill-suite#organize-agents) | Registry of agent runs across every tool |
| 7 | [`pure-orchestrator`](https://github.com/AQaddora/pure-skill-suite#pure-orchestrator) | Runs the full P→U→R→E loop with checkpoints |
| 8 | [`handoff`](https://github.com/AQaddora/pure-skill-suite#project-handoff) | Migrates a long session to a fresh chat without losing state |

All 8 are MIT licensed. The orchestrator pulls in the others. `./install.sh` in this repo clones the suite and runs its installer — you don't have to clone both manually.

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
├── LICENSE                    ← course content terms
├── CONTRIBUTING.md
├── install.sh                 ← shim — clones pure-skill-suite + runs its installer
│
├── sessions/                  ← course material (5 sessions, free)
│   ├── session-01-mindset/    ← ✅ Free lead magnet
│   ├── session-02-defense/    ← ⏳ paid pre-course
│   ├── session-03-mvp/        ← ⏳ paid pre-course
│   ├── session-04-saas/       ← ⏳ paid pre-course
│   └── session-05-career/     ← ⏳ paid pre-course
│
├── templates/                 ← per-tool config templates (CLAUDE.md, etc.) — MIT
├── tools/                     ← session scaffolders + slide build helpers — MIT
├── docs/                      ← extended docs (pricing, FAQ, changelog)
└── .github/                   ← issue templates + CI
```

The 8 skills live separately in [**AQaddora/pure-skill-suite**](https://github.com/AQaddora/pure-skill-suite) — install via `./install.sh` above, which clones the suite as a sibling directory and runs its installer.

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
| Everything in `templates/`, `tools/`, `.github/`, plus `install.sh` | **MIT** — use, fork, build on |
| The 8 skills (in [`pure-skill-suite`](https://github.com/AQaddora/pure-skill-suite)) | **MIT** — separate repo, separate distribution |
| Everything in `sessions/`, `docs/` | **Free to learn from. Copyright Ahmed Qaddoura — do not republish or repackage.** |
| The **PURE Loop** and **AI Doctrine** framework names | Credit when referencing — they're Ahmed's invention |

See [LICENSE](LICENSE) for the full text.

## What's next in the Mastery program

This is the **Mindset Foundations** tier — free, opinionated, and load-bearing for everything that comes after. The next tiers in the same Vibe Coding Mastery program will go deeper into building, securing, and monetizing real AI products. Pricing and timing for those tiers will be announced when they're ready — not before.

## Stay in the loop

📌 Mailing list: [aqaddoura.com](https://aqaddoura.com) — get a heads-up when Sessions 2–5 drop and when the next Mastery tier ships
📌 Star this repo on GitHub to follow along as content is added

---

```
// yalla — let's build.
```

*Vibe Coding Mastery · Palestine Innovation Initiative · Taqat Academy · Kawkab.ai · 2026*
