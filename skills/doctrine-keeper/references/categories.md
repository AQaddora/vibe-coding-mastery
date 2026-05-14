# Doctrine Categories — Reference

Every entry is tagged with one category. Categories map to the PURE Loop + one extra for failure modes.

---

## P — Prime (Context-Setting Rules)

**What it covers:** Rules about how to set up AI before asking it anything serious.

Includes:
- What context to provide (stack, versions, style)
- Which constraints to state explicitly
- Threat model statements
- Audience/use-case framing
- Code style preferences

**Example trigger:** "AI keeps giving me React class components when my codebase is all hooks. Need a rule for this."

**Sample rule titles:**
- "Always state Python version + Pydantic version in primer"
- "Specify 'functional components only, no class components' when working in modern React"
- "State 'assume hostile input' for any user-facing endpoint"

---

## U — Understand (Verification & Comprehension Rules)

**What it covers:** Rules about how to read and verify AI output before accepting it.

Includes:
- What to look for when reading AI-generated code
- Specific questions to ask AI about its own output
- Common patterns to verify against
- Documentation lookups that must always happen

**Example trigger:** "I caught Claude using a deprecated function today. Need to remember to check."

**Sample rule titles:**
- "Verify every imported package actually exists on npmjs.com"
- "When AI uses a Python stdlib function, check it's not deprecated in 3.12+"
- "Ask AI: 'why this approach over X?' for any non-obvious choice"

---

## R — Refine (Iteration & Review Rules)

**What it covers:** Rules about how to improve AI's first-pass output.

Includes:
- Standard follow-up prompts that always improve quality
- Self-review patterns ("review your code as a senior X")
- Comparison patterns ("show me 3 approaches, then pick best")
- Counter-prompts that catch specific issue classes

**Example trigger:** "That trick of asking Claude to review its own code as a security engineer caught 4 bugs. Need to save this."

**Sample rule titles:**
- "After auth code: always ask 'threat-model this as a senior security engineer'"
- "After SQL: always ask 'rewrite this assuming the input is hostile'"
- "After API design: always ask 'show me how this fails in 3 different ways'"

---

## E — Execute (Workflow & Tooling Rules)

**What it covers:** Rules about how you actually run, deploy, and operate AI-generated code.

Includes:
- Testing workflows
- Deployment checklists
- Monitoring patterns
- When to commit vs throw away AI code
- Environment setup conventions

**Example trigger:** "I deployed AI code without integration tests and broke prod. Need a rule."

**Sample rule titles:**
- "Never deploy AI-generated DB migrations without running on staging copy of prod first"
- "Always write at least 1 integration test before merging AI-generated route handlers"
- "Run AI-generated code through your linter + type-checker BEFORE reading it manually"

---

## T — Trap (Failure Modes to Avoid)

**What it covers:** Rules about specific AI mistakes you've seen, so you recognize them next time.

This is the most valuable category for long-term learning. Each Trap entry is a vaccine.

Includes:
- Hallucinated APIs/packages/functions
- Wrong-version syntax (Python 2 vs 3, Pydantic v1 vs v2)
- Security anti-patterns AI confidently suggests
- Performance traps (N+1 queries, blocking I/O in async)
- Misleading variable names AI invents

**Example trigger:** "Claude invented a `useFormFields` hook that doesn't exist in any library."

**Sample rule titles:**
- "TRAP: AI invents `useFormFields` hook — verify all React hooks against actual library docs"
- "TRAP: AI suggests `dangerouslySetInnerHTML` for displaying markdown — always use a sanitizer"
- "TRAP: AI uses `localStorage` for auth tokens — always reject, use httpOnly cookies"

---

## How To Choose a Category When in Doubt

Ask yourself: **What stage of PURE was I in when I learned this?**

- "I was setting up context" → **Prime**
- "I was reading the output" → **Understand**
- "I was iterating on the output" → **Refine**
- "I was running/deploying" → **Execute**
- "AI did something specific that surprised me" → **Trap**

If a rule fits two categories, pick the **earliest** one in the loop. A rule about "always specify Postgres version" is technically about understanding output, but it belongs to Prime because that's where you'd add it to your default primer.

---

## Category Distribution (Healthy Doctrine)

A mature doctrine typically has this rough split after 50+ rules:

- **Prime:** 30–40% (most rules are about better setup)
- **Refine:** 20–25% (high-leverage iteration patterns)
- **Trap:** 20–25% (war stories preserved as warnings)
- **Understand:** 10–15% (verification rituals)
- **Execute:** 5–10% (workflow rules)

If your doctrine is 80% Traps, you're operating reactively. Time to shift toward Prime — preventing the traps before they happen.
