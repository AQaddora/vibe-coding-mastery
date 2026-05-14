---
name: organize-agents
description: Maintains a registry of agent runs and outputs across every coding agent the user works with (Claude Code, Cursor, Codex, Aider, Gemini CLI, Windsurf). Triggers on "list agents", "show recent runs", "agent status", "what's in flight", "find that run from yesterday". Reads from ./runs/ and ~/.vibe-coding/runs/, provides search, tagging, and outcome tracking. Writes runtime patterns and lessons back to ~/ai-doctrine.md so every tool benefits from the user's accumulated agent operating experience.
license: MIT
---

# Organize Agents

The runbook for everything you've delegated to a coding agent.

Once you start running real work through Claude Code, Cursor agent mode, Codex CLI, and Aider in parallel, "what was I working on?" becomes a real question. This skill is the answer.

## When to Use This Skill

Trigger when the user:

- Says "list agents", "show recent runs", "what's in flight", "agent status"
- Asks "where did that JWT refactor end up?" — needs to find a past run
- Wants to audit how many agent runs they've done this week and on what
- Asks for outcome stats — "how many of my agent runs needed a Refine v3?"
- Hands off a task to a different agent and wants the prior context loaded

## How It Works (4-Step Protocol)

### Step 1 — Discover runs

Scan, in order:

1. `./runs/` — project-scoped runs
2. `~/.vibe-coding/runs/` — global runs
3. Output: a unified list with timestamps, agents, status, slugs

### Step 2 — Render the registry

Default view (last 20 runs):

```
RUN ID                          AGENT         STATUS       AGE       GOAL
exec-2026-05-13-jwt-refactor    claude-code   completed    2h        Harden JWT refresh path
exec-2026-05-13-add-search      cursor        in_progress  45m       Add substring user search
exec-2026-05-12-fix-n+1         aider         completed    1d        Fix N+1 in /orders endpoint
exec-2026-05-12-add-rls         codex         failed       1d        Add row-level security
…
```

Filters: `--agent claude-code`, `--status failed`, `--since 7d`, `--search "JWT"`.

### Step 3 — Drill in

When the user picks a run:

- Show the runfile
- Show the linked Refine notes
- Show the final diff (link or paste)
- Show the doctrine entries this run produced

### Step 4 — Identify patterns

After every 20–30 runs, the skill offers a pattern summary:

- Which agents complete vs fail by task type
- Which Refine prompts repeat across runs (doctrine candidate)
- Which acceptance-criteria checkboxes get skipped most often (process candidate)

Save findings via `doctrine-keeper`. After `sync_to_agents.sh`, the same intelligence is loaded into every tool.

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file |
| `references/registry-schema.md` | Schema for the runs registry — TODO |
| `scripts/README.md` | Scripts placeholder |

## Operational Rules

1. **Never lose a run.** Even abandoned runs stay in the registry — they're high-signal training data for the user.
2. **One run per task.** If a task forks (different approach, different agent), make it a new run that links back.
3. **Tag everything.** Every run gets at least one tag (`auth`, `frontend`, `data`, etc.) for later analytics.
4. **Privacy aware.** Runfiles can contain code snippets — never publish them. Default `runs/` to `.gitignore`-ed.
5. **Don't compete with git.** The registry tracks intent and outcome, not code history. Git owns the diff.

## Doctrine Integration

Two save patterns:

1. **Execute-category rules** from observed patterns — "For data-migration tasks, codex CLI succeeds 80% of the time, claude-code agent mode struggles. Default to codex."
2. **Process rules** — "Always tag runs with the doctrine category they relate to so monthly reviews are filterable."

Save through `doctrine-keeper`. After `sync_to_agents.sh`, the same intelligence is loaded into Cursor / Copilot / Codex / Gemini / Windsurf.

## Example Invocation

**User:** "Show me my agent runs from this week."

**Skill activates:**

```
RUN ID                          AGENT         STATUS       AGE      GOAL
exec-2026-05-13-jwt-refactor    claude-code   completed    2h       Harden JWT refresh path
exec-2026-05-13-add-search      cursor        in_progress  45m      Add substring user search
exec-2026-05-12-fix-n+1         aider         completed    1d       Fix N+1 in /orders endpoint
exec-2026-05-12-add-rls         codex         failed       1d       Add row-level security
exec-2026-05-11-onboarding-ux   cursor        completed    2d       Redesign onboarding flow
```

> **Patterns this week:**
> - Cursor: 2/2 completed for UX/frontend tasks
> - Codex: 0/1 completed for DB security — failure was "missed multi-tenant constraint"
>
> 💡 Doctrine candidate: "For row-level security / multi-tenancy tasks, prefer claude-code agent mode with explicit RLS reviewer role over codex." Save as Execute rule?

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed.*
