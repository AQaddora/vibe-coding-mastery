# Skills — The PURE + AI Doctrine Skill Suite

Eight AI coding skills that work together as a **cross-tool memory and operating system** for developers using Claude, Cursor, Copilot, Codex, Gemini CLI, Aider, and Windsurf.

Invented and maintained by [Ahmed Qaddoura](https://aqaddoura.com).

## Install

From the repo root:

```bash
git clone https://github.com/AQaddora/vibe-coding-mastery.git
cd vibe-coding-mastery
./skills/install.sh
```

The installer:

1. Bootstraps `~/ai-doctrine.md` (your personal rulebook — written once, grown forever)
2. Installs all 7 skills into `~/.claude/skills/`
3. Optionally wires the doctrine into your current project so every AI tool reads it

## The 8 skills

| # | Skill | One-line purpose | Status |
| --- | --- | --- | --- |
| 1 | [`doctrine-keeper`](doctrine-keeper/SKILL.md) | The memory bus. Captures every rule you learn into `~/ai-doctrine.md`. | ✅ Final |
| 2 | [`prime`](prime/SKILL.md) | **P** of PURE. Builds the primer that loads before any real task. | 🧱 Skeleton |
| 3 | [`understand`](understand/SKILL.md) | **U** of PURE. Clarifies scope before code is written. | 🧱 Skeleton |
| 4 | [`refine`](refine/SKILL.md) | **R** of PURE. Senior-reviewer self-review on AI output. | 🧱 Skeleton |
| 5 | [`execute`](execute/SKILL.md) | **E** of PURE. Delegates work to a coding agent and tracks the run. | 🧱 Skeleton |
| 6 | [`organize-agents`](organize-agents/SKILL.md) | Registry of agent runs across every tool you use. | 🧱 Skeleton |
| 7 | [`pure-orchestrator`](pure-orchestrator/SKILL.md) | Runs the full P→U→R→E loop end-to-end with user checkpoints. | 🧱 Skeleton |
| 8 | [`handoff`](handoff/SKILL.md) | Migrates a long session to a fresh chat without losing state. | 🧱 Skeleton |

Skeleton = structure + descriptions + protocol are final. Scripts and helper logic are being built in dedicated sessions and shipped progressively.

## How the skills work together

```
Feature request
       │
       ▼
┌─────────────────────┐
│  pure-orchestrator  │  ← entry point
└──────────┬──────────┘
           │
           ▼
         prime    ←  loads context from doctrine
           │
           ├── [context-pressure gate]
           │       │
           │       ▼
           │   handoff  ← optional: migrate to fresh chat with state preserved
           │
           ▼
        understand  refine  execute  ←  rest of the PURE phases
                                │
                                ▼
                       organize-agents  ← tracks the agent run
                                │
                                ▼
                       doctrine-keeper  ← saves learnings
                                │
                                ▼
                       ~/ai-doctrine.md  ← single source of truth
                                │
                                │  symlinked by sync_to_agents.sh
                                ▼
            CLAUDE.md · .cursorrules · AGENTS.md ·
            .github/copilot-instructions.md · .windsurfrules
            (every tool reads the same memory)
```

## The cross-tool memory pillar

Every skill in this suite writes back to the same `~/ai-doctrine.md`. That file is symlinked into the config locations of:

- **Claude Code** — `CLAUDE.md`
- **Codex / OpenAI Apps / Gemini CLI** — `AGENTS.md`
- **Cursor** — `.cursorrules` + `.cursor/rules/doctrine.mdc`
- **GitHub Copilot** — `.github/copilot-instructions.md`
- **Windsurf** — `.windsurfrules`

Result: when you save a rule in Claude, Cursor reads it the next time you open it in that project. When you discover a primer that works while pairing with Codex, Copilot picks it up automatically.

You teach your AI tools *once*. They remember together.

## Try it (90 seconds)

```bash
# Install
./skills/install.sh

# Fill in your primer (one-time)
$EDITOR ~/ai-doctrine.md   # find "My Default Primer" — replace with your stack

# Open Claude and type one of:
"prime me for a FastAPI feature"           # the prime skill builds a primer
"run PURE on adding tenant audit logging"  # the orchestrator runs the full loop
"add to doctrine: always state Pydantic v2 in primer"  # doctrine-keeper captures a rule

# Open Cursor or Copilot in the same project — they read the same rules.
```

## Contributing

PRs welcome on skill scripts, additional template integrations, and references. See [CONTRIBUTING.md](../CONTRIBUTING.md).

Skill content (the PURE framework, AI Doctrine, the protocol) is the IP of Ahmed Qaddoura — please credit the source when referencing or building on it.

## License

MIT for the skills themselves. The PURE + AI Doctrine **framework** is credited to Ahmed Qaddoura — fair use of the names is welcome with attribution.

---

[← Repo root](../README.md) · [Templates](../templates/README.md) · [Sessions](../sessions/README.md)
