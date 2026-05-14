# SESSION 1 — PRACTICAL WALKTHROUGH
## Live Demonstration: The PURE Loop in Action

**Recording segment:** Inserts at ~[00:25] of the speaker script
**Duration on screen:** ~3 minutes
**What to show:** Real Claude.ai session with the four PURE phases visible

---

## Goal of This Demo

Show the trainee what PURE looks like with their own eyes — not as a theory, as a craft. After watching this, they should be able to replicate it in their own session within an hour.

---

## Pre-Demo Setup

### Browser
- Claude.ai open, logged in, **clean conversation** (no prior context)
- Browser window: 1440×900 minimum, zoom set to 110% so text is readable on video
- Hide bookmarks bar
- One extension visible at most

### The Task
You will demonstrate PURE on a **real but small task**: writing a Python function that validates a user's freelancer profile data.

This task is chosen because:
- It's small enough to complete in 3 minutes
- It has obvious security pitfalls (input validation)
- It's relatable for the target audience
- AI's first attempt will be naive — demonstrating why PURE matters

---

## The Demo Script (Screen Recording)

### Phase 1 — PRIME (45 seconds)

**Type into Claude.ai:**

```
Context: I'm building a freelancer SaaS in FastAPI + PostgreSQL.
Stack: Python 3.11, Pydantic v2, FastAPI 0.110+, asyncpg.
Style: type hints everywhere, no print statements, pytest for tests.
Constraints: this code will run in production with real user data.
Security: assume all inputs are hostile.

I will give you tasks one at a time. Confirm you understand
the context, then wait for the task.
```

**While typing, narrate:**
> "Notice what I did not do. I did not say 'help me write a validator'. That is what Camp A does. Camp A asks for code. Camp B *primes context first*. Watch what changes."

**Claude responds confirming context.**

**Narrate:**
> "Now Claude knows my stack, my style, my constraints, and my threat model. Every line of code it writes from this point on is shaped by what I just told it. This is the single highest-leverage move you will make all week."

---

### Phase 2 — UNDERSTAND (60 seconds)

**Type:**

```
Task: write a Pydantic v2 model for a Freelancer profile.
Fields: full_name, email, country_iso2, hourly_rate_usd,
skills (list of strings), portfolio_url.
```

**Claude returns a model.**

**Narrate (while pointing at code on screen):**
> "Camp A would copy this into their IDE right now. We don't. We *read it*.
>
> Look here — full_name is a `str` with no length limit. That's a denial-of-service vector if someone submits a 10-megabyte string.
>
> Email — it used `EmailStr`. Good. But it didn't normalize the case. Two users could register the same email with different capitalization.
>
> Skills — a list of strings with no max length. Same DoS issue.
>
> Portfolio URL — `HttpUrl`. Looks good. But does it block javascript: URIs? Internal IP addresses? Localhost? Those are real attacks.
>
> If I shipped this, my product has four security issues on day one. And I would not have known."

---

### Phase 3 — REFINE (50 seconds)

**Type:**

```
Review your own code as a senior security engineer would.
List every vulnerability and edge case you missed.
Then rewrite it.
```

**Claude responds with a revised model that adds:**
- `max_length` constraints on strings
- Email normalization with `@field_validator`
- A `max_items` on skills list
- URL scheme allowlist (only http/https)
- Hourly rate min/max bounds

**Narrate:**
> "That is the move. The first answer is rarely the best answer. *Asking the same AI to review its own work* is the cheapest, fastest code review you will ever get.
>
> Use this pattern every time. Not sometimes. Every time."

---

### Phase 4 — EXECUTE (25 seconds)

**Switch to VS Code. Paste the refined model. Run a quick pytest.**

**Narrate:**
> "Now I execute. And the most important step — I write down what I learned.
>
> *[Open a notes file labeled `ai-doctrine.md`]*
>
> 'Pydantic models from AI need: explicit max_length, email normalization, URL scheme allowlist, numeric bounds.'
>
> That note goes into my doctrine file. Tomorrow when I write the next model, I will paste these constraints into my prime. The system gets smarter every week. You get faster every week."

---

### Wrap (10 seconds)

**Cut back to face camera.**

> "Four phases. Three minutes. A model my future self can trust.
>
> *That* is vibe coding. Not 'tab through suggestions and hope for the best'."

---

## Files Used in Demo

Save these in `/precourse/session-1/demo-assets/`:

### `freelancer_naive.py` (the first AI output — pre-recorded as a backup)
```python
from pydantic import BaseModel, EmailStr, HttpUrl
from typing import List

class FreelancerProfile(BaseModel):
    full_name: str
    email: EmailStr
    country_iso2: str
    hourly_rate_usd: float
    skills: List[str]
    portfolio_url: HttpUrl
```

### `freelancer_refined.py` (the second AI output)
```python
from pydantic import BaseModel, EmailStr, HttpUrl, Field, field_validator
from typing import List, Annotated

class FreelancerProfile(BaseModel):
    full_name: Annotated[str, Field(min_length=2, max_length=120)]
    email: EmailStr
    country_iso2: Annotated[str, Field(min_length=2, max_length=2, pattern=r"^[A-Z]{2}$")]
    hourly_rate_usd: Annotated[float, Field(gt=0, le=10_000)]
    skills: Annotated[List[Annotated[str, Field(max_length=40)]], Field(max_length=30)]
    portfolio_url: HttpUrl

    @field_validator("email")
    @classmethod
    def normalize_email(cls, v: str) -> str:
        return v.lower().strip()

    @field_validator("portfolio_url")
    @classmethod
    def restrict_scheme(cls, v):
        if v.scheme not in {"http", "https"}:
            raise ValueError("Only http/https URLs are allowed")
        return v
```

### `ai-doctrine.md` (the running notes file — start of trainee's doctrine)
```markdown
# AI Operating Doctrine — Ahmed Qaddoura

## Pydantic Models
- Always add explicit max_length on every string field
- Normalize emails (lowercase + strip)
- Restrict URL schemes (no javascript:, no file:, no data:)
- Bound all numeric fields (gt, lt)
- Cap list lengths to prevent DoS

## General Priming
- State stack, style, constraints, threat model
- Treat first AI output as a draft, never as the answer
- Always ask AI to review its own code as a senior would
```

---

## Recording Tips

### What to Show On Screen
- **Left half of screen:** Claude.ai conversation
- **Right half of screen:** VS Code with the file you're building
- Switch focus between them by clicking — viewers follow your mouse

### Cursor Highlighting
Use a tool like Mouseposé or built-in macOS zoom to spotlight your cursor when you're pointing at specific lines.

### Pre-Record Backup
Run the entire demo once before recording. If Claude gives a wildly different answer on the day of recording, you have screenshots and the saved conversation to fall back to.

### Total Demo Length
Keep the whole demo under 3 minutes on screen. If you go longer, viewers lose the thread back to the principle (PURE).

---

## What This Demo Proves

By the end of these 3 minutes, the trainee has seen:
1. **PRIME** is not optional and changes everything downstream
2. **UNDERSTAND** catches issues that would otherwise ship to production
3. **REFINE** is a free, repeatable security review
4. **EXECUTE** includes capturing learnings — not just running code
5. The doctrine file is a real, growing asset they will build over time

This single demo is more valuable than 90% of paid AI courses on the market. Most courses teach prompts. You are teaching a craft.
