---
name: pure-orchestrator
description: Runs the full PURE Loop (Prime → Understand → Refine → Execute) on a feature request, calling each phase's skill in sequence with explicit checkpoints for user approval. Triggers on "run PURE on...", "process this feature", "PURE this", "full loop", or any large feature request the user wants handled methodically. Always concludes by offering to capture learnings from all four phases into ~/ai-doctrine.md so the same playbook improves every other AI tool the user works with (Cursor, Copilot, Codex, Gemini, Windsurf).
license: MIT
---

# PURE Orchestrator

The conductor.

Most AI sessions skip phases. The user types a feature request, gets code back, and ships. This skill enforces the four-phase discipline that turns AI from autocomplete into a real pair.

## When to Use This Skill

Trigger when the user:

- Says "run PURE on...", "PURE this", "full loop", "process this feature"
- Hands over a large feature request and doesn't specify which phase to start in
- Wants enforced quality on a high-stakes task (auth, payments, migrations)
- Is teaching a junior or recording a demo and wants every phase visible

## How It Works (4-Phase Protocol + Context-Pressure Gate)

The skill calls the four PURE skills in sequence, with explicit checkpoints between phases. Between Phase 1 (Prime) and Phase 2 (Understand) there is a **context-pressure gate** that may invoke the `handoff` skill if the orchestrator detects the remaining work won't fit the current conversation.

### Phase 1 — Prime

Invoke `prime` skill. Outputs primer block. **Checkpoint:** user approves primer. If no, route back to Prime with the user's correction.

### Context-pressure gate (between Phase 1 and Phase 2)

After Prime completes — before invoking Understand — assess context pressure heuristically:

- Has the conversation exceeded ~40 turns?
- Have >10 files been read into context?
- Has the task scope expanded substantially since the user's original ask?
- Is the user reporting the AI is "forgetting" earlier instructions?
- Did the user explicitly request a handoff?

If any of these are true, **pause and offer a handoff before continuing**:

> *"Quick check — context is starting to fill up. Want me to prepare a handoff block so we can continue this PURE loop in a fresh chat with full state? Prime is already complete, so the new chat will boot loaded."*

If the user approves, invoke the `handoff` skill. The handoff block carries the approved primer reference + the original task + locked decisions so far. The user pastes into a fresh chat, the orchestrator resumes at **Phase 2 (Understand)**.

If the user declines or no pressure is detected, continue to Phase 2 normally.

### Phase 2 — Understand

Invoke `understand` skill with primer + task. Outputs comprehension brief. **Checkpoint:** user approves brief. If no, ask one clarifying question and re-run.

### Phase 3 — Refine

Invoke `refine` skill on the *plan* (not the code yet). Outputs a refined plan with reviewer-role critique. **Checkpoint:** user approves refined plan. If no, route back with feedback.

### Phase 4 — Execute

Invoke `execute` skill with the approved plan. Generates runfile, hands off to agent. **Checkpoint:** agent completes, output verified by one final Refine pass on the code. User approves.

### Phase 5 — Capture (always)

After Execute closes, automatically prompt the user with the **highest-leverage doctrine candidates** from across all four phases:

- New primer fields (Prime)
- Clarification patterns that worked (Understand)
- Review prompts that caught real bugs (Refine)
- Agent/task pairings that succeeded (Execute)

User picks which to save. Routes through `doctrine-keeper`. After `sync_to_agents.sh`, the loop just improved every other tool too.

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file |
| `references/phase-protocol.md` | Detailed checkpoint contracts per phase — TODO |
| `scripts/README.md` | Scripts placeholder |

## Operational Rules

1. **Never skip phases.** If the user says "just give me code", offer a fast-track Understand (one minute) + Execute path, but log it as a deviation so the user notices.
2. **Checkpoints are blocking.** Don't move to the next phase without explicit user approval.
3. **One feature per loop.** If the user's request spans 3 features, split into 3 runs.
4. **Surface deviations.** If the user overrides a phase's default ("skip Refine"), log the override in the final runfile so it shows up in `organize-agents` analytics.
5. **Capture is non-negotiable.** Even if the user passes on saving any doctrine entries, *ask* — the question itself is part of the discipline.
6. **Handoff between Prime and Understand only.** Context-pressure detection runs AFTER Prime completes (so the handoff carries a valid primer) and BEFORE Understand begins (so no scope work is lost). Don't fire the handoff mid-Understand or mid-Refine — wait until the next natural phase boundary.

## Doctrine Integration

This skill is the highest-yield writer to `~/ai-doctrine.md`. Every loop generates 1–5 doctrine candidates by design.

The capture phase is where the user's *system* compounds:

- Day 1: 3 rules saved.
- Week 4: 25 rules. Cursor and Copilot now ask the same clarifying questions Claude does.
- Month 6: 100 rules. The user's primer is 80% pre-loaded for every project. New AI tools "feel like home" the first time they open them.

Routes through `doctrine-keeper`, propagates via `sync_to_agents.sh`.

## Example Invocation

**User:** "Run PURE on adding tenant-scoped audit logging."

**Skill activates:**

> **PURE Loop initiated** — feature: tenant-scoped audit logging
>
> ───────────────────────────────────────────────
> **Phase 1: Prime**
>
> Loading from ~/ai-doctrine.md Default Primer + Prime rules tagged `tenant` / `audit`...
> *[primer block shown]*
>
> Approve primer? [y/n]
>
> ───────────────────────────────────────────────
> **Phase 2: Understand**
>
> Surface: Add audit logging scoped to current tenant.
> Inferred (from primer + your CLAUDE.md): admin actions only, append-only table, retained for 90 days.
>
> Blocking question: log to existing `audit_log` table or new table per event type?
>
> *[user answers]*
>
> Comprehension brief: *[shown]*
>
> Approve brief? [y/n]
>
> ───────────────────────────────────────────────
> **Phase 3: Refine**
>
> Reviewer role: Senior security engineer + multi-tenancy auditor.
> Plan issues found: 4 (PII redaction missing, RLS not enforced on the log table, retention deletion path not idempotent, no rate limit on log writes).
> Refined plan: *[shown]*
>
> Approve refined plan? [y/n]
>
> ───────────────────────────────────────────────
> **Phase 4: Execute**
>
> Runfile: `runs/exec-2026-05-13-tenant-audit-log.md`
> Agent: Claude Code
>
> Run it. I'll wait for the diff.
>
> *[agent completes, final refine pass, user approves]*
>
> ───────────────────────────────────────────────
> **Phase 5: Capture**
>
> Doctrine candidates from this loop:
> 1. *Prime:* "For any audit-logging request, always include retention policy in primer."
> 2. *Understand:* "Always clarify single audit table vs per-event-type before planning."
> 3. *Refine:* "For audit logs, run senior-security + multi-tenancy auditor reviewer roles in parallel."
> 4. *Execute:* "Claude Code agent mode + RLS reviewer role completes tenant security tasks reliably."
>
> Save which? (1, 2, 3, 4, all, none)

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed.*
