# Doctrine Entry Format — Reference

This is the canonical format every doctrine entry must follow. The format is optimized for:
- **Searchability** — categories and tags so you can grep for related rules
- **Recall** — concrete examples and snippets you can copy-paste
- **Compounding** — entries reinforce each other when read in sequence

## Template

```markdown
## [YYYY-MM-DD] — [Short Title in 4–8 Words]

**Category:** [Prime | Understand | Refine | Execute | Trap]
**Stack:** [Comma-separated tech, e.g., FastAPI, Pydantic v2, PostgreSQL]
**Severity:** [Low | Medium | High | Critical]
**Tags:** [#optional, #freeform, #tags]

### The Rule
[One sentence. Imperative. Specific.]

### Why It Matters
[1–2 sentences. The concrete cost of ignoring it.]

### Triggering Prompt
> [Verbatim or close paraphrase of the prompt that led to the insight.]

### What Went Wrong / Right
[1–3 sentences. Be specific.]

### How To Apply Next Time
[Reusable snippet, checklist, or counter-prompt.]

---
```

## Severity Scale

| Level | Meaning | Examples |
|---|---|---|
| **Low** | Style preference, minor efficiency | Use `pathlib` over `os.path` in primers |
| **Medium** | Saves significant time or prevents minor bugs | Always state Pydantic version |
| **High** | Prevents real production bugs or security issues | Always require AI to add input length limits |
| **Critical** | Prevents data loss, auth breaches, financial errors | Never let AI write SQL without parameterization |

## Real Examples (Annotated)

### Example 1 — A "Prime" rule (Medium severity)

```markdown
## 2026-03-04 — State async vs sync explicitly in primer

**Category:** Prime
**Stack:** FastAPI, asyncpg
**Severity:** Medium
**Tags:** #async #database

### The Rule
When asking AI for database code in a FastAPI project, explicitly state "use async/await with asyncpg" — don't trust it to infer.

### Why It Matters
AI defaults to synchronous SQLAlchemy ~40% of the time even in async codebases. Mixing causes hangs in production.

### Triggering Prompt
> "Write me a function that fetches user by email"

### What Went Wrong
First answer used `psycopg2.connect()` synchronously inside an async route handler. Would have deadlocked under load.

### How To Apply Next Time
Add to primer:
`Database: PostgreSQL via asyncpg. ALL DB calls must use async/await. Never use psycopg2 or synchronous SQLAlchemy.`
```

### Example 2 — A "Trap" rule (Critical severity)

```markdown
## 2026-03-11 — AI invents npm packages that don't exist

**Category:** Trap
**Stack:** Node.js, npm
**Severity:** Critical
**Tags:** #supply-chain #security #hallucination

### The Rule
When AI suggests an npm package you haven't heard of, verify on npmjs.com BEFORE running `npm install`. Hallucinated package names are a real supply-chain attack vector.

### Why It Matters
"Slopsquatting" — attackers publish malicious packages with names AI commonly hallucinates. Installing one = backdoored machine.

### Triggering Prompt
> "How do I parse RFC 7807 problem details in Express?"

### What Went Wrong
AI suggested `express-problem-details` — a package that does not exist. A malicious version could be published tomorrow with that exact name.

### How To Apply Next Time
1. Before any `npm install`, verify the package exists on npmjs.com
2. Check weekly downloads (less than 1,000/week = suspicious for a "standard" library)
3. Add to Refine step: "verify every package name you suggested actually exists"
```

### Example 3 — A "Refine" rule (High severity)

```markdown
## 2026-04-22 — Always ask AI to threat-model its own auth code

**Category:** Refine
**Stack:** Any auth implementation
**Severity:** High
**Tags:** #auth #security #review

### The Rule
After AI writes any authentication/authorization code, immediately follow up with:
"Now threat-model this code as a senior security engineer. List every attack vector, weakness, and missing check. Then rewrite addressing all of them."

### Why It Matters
First-pass AI auth code is typically OWASP Top 10 fodder. Second pass catches 80% of issues for free.

### Triggering Prompt
> "Write me a JWT-based auth flow for FastAPI"

### What Went Right
First version: no token expiry check, no signature algorithm pinning, no rate limiting.
After threat-model prompt: all three added plus refresh token rotation and revocation list.

### How To Apply Next Time
Save as a reusable Refine prompt:
`Review this code as a senior security engineer. List every attack vector and missing defense. Then rewrite addressing all of them. Be exhaustive — assume the input is hostile.`
```

## Anti-Patterns (Don't Do This)

❌ **Vague rules:**
> "Be careful with AI."
> "Always review code."
> "Don't trust LLMs blindly."

✅ **Specific rules:**
> "When AI suggests a regex for email validation, always replace with `EmailStr` from Pydantic or `email_validator` library."

❌ **Rules without context:**
> "Use max_length."

✅ **Rules with the why:**
> "Always set `max_length` on Pydantic string fields exposed to user input. Without it, a 10MB string = guaranteed DoS."

❌ **Rules that won't trigger recall:**
> "Verify outputs."

✅ **Rules with a triggering prompt pattern:**
> "When prompting for SQL: always specify the exact PostgreSQL version + indexing strategy in the primer. Without it, AI generates queries that work in MySQL but fail in Postgres."
