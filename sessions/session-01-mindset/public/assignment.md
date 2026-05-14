# SESSION 1 — ASSIGNMENT
## Run Your First PURE Loop

**Time required:** 60 minutes
**Deliverables:** 1 working artifact + 1 paragraph reflection + start of your AI Doctrine file
**Due:** Before you watch Session 2

---

## The Task

Pick **one real task** you would normally do this week. Not a tutorial example. Something real:

- A function you need to write for work
- A bug you need to investigate
- A piece of documentation you need to draft
- An email you need to send
- A SQL query you need to optimize
- A small feature you've been putting off

Run that task through the **full PURE loop** with Claude (or your AI tool of choice). Then document what happened.

---

## Step-By-Step

### Step 1 — PRIME (10 minutes)
Open a fresh Claude session. Before stating your task, write a primer that includes:

- [ ] Your tech stack (languages, frameworks, versions if relevant)
- [ ] Your style preferences (naming conventions, code style, testing approach)
- [ ] Your constraints (performance targets, security requirements, deadlines)
- [ ] Your audience (who reads or runs this output — junior dev? users? operations team?)
- [ ] Your threat model if applicable (production code, hostile inputs, sensitive data)

**Submission requirement:** Save your primer as `primer.md`.

### Step 2 — UNDERSTAND (15 minutes)
Submit your task. Receive the first AI response.

**Do not paste the output anywhere yet.**

Instead:
- Read every line
- Mark anything you don't fully understand
- For each marked item, ask the AI to explain it
- For each explanation, ask "why did you choose this over X?"

**Submission requirement:** A second file `understanding-notes.md` with at least three things you learned during this phase. Things you didn't know before.

### Step 3 — REFINE (15 minutes)
Send these three follow-up prompts in order:

1. *"Review your own answer as a senior engineer would. List every weakness, edge case, and risk."*
2. *"Now rewrite it addressing every issue you just identified."*
3. *"Compare your two versions. What did the second version teach you about what to ask for the first time?"*

**Submission requirement:** Save the final refined output as your working artifact.

### Step 4 — EXECUTE (15 minutes)
Use the refined output for its actual purpose. Run the code, send the email, deploy the function — whatever applies.

Capture:
- Did it work?
- What did you have to modify?
- How long did the whole process take vs. doing it manually?

### Step 5 — DOCTRINE (5 minutes)
Open or create a file called `ai-doctrine.md` in your personal notes.

Add at least **three rules** based on what you learned today. These rules should be specific and reusable. Examples:

- *"When asking AI for SQL, always specify the database engine version and indexing strategy."*
- *"For email drafts, always specify recipient context and one explicit desired outcome."*
- *"For code, always demand input validation as a first review pass."*

This file is yours forever. By Session 5, it will have 15+ rules. By the end of the main course, 50+.

---

## Reflection Paragraph

Write one paragraph (4-6 sentences) answering all of these:

1. What was the biggest surprise during the PURE loop?
2. Which phase did you find hardest? Why?
3. Would you have shipped the first AI answer if you hadn't done REFINE?
4. What is one rule you added to your doctrine?

Save as `reflection.md`.

---

## Rubric (For Self-Assessment)

You pass this assignment if:

| Criterion | Pass Condition |
|-----------|---------------|
| **Primer quality** | At least 4 of 5 categories present (stack, style, constraints, audience, threat model) |
| **Understanding depth** | At least 3 things noted that you genuinely didn't know |
| **Refinement difference** | The refined version is materially different from the first answer |
| **Real execution** | You actually used the output for its real purpose |
| **Doctrine started** | At least 3 specific, reusable rules captured |
| **Reflection honesty** | The reflection is honest — including what was hard or didn't work |

If you can check all six boxes, you have completed Session 1.

---

## Stretch Challenge (Optional)

If you want to go deeper before Session 2:

Run the same PURE loop on a **second task in a completely different domain**. If your first task was code, make the second one writing or strategy. If your first was technical, make the second one operational.

Compare: which domain did AI help more in? Which phase mattered most in each? What does that tell you about where AI gives you the most leverage?

This is the question Level 4 operators are constantly asking themselves. Start asking it now.

---

## Submission Format

Bundle all files into a folder called `session-1-ahmed-pure-loop/`:

```
session-1-ahmed-pure-loop/
├── primer.md
├── understanding-notes.md
├── refined-output.[ext]   ← the actual artifact (code, doc, email, etc.)
├── ai-doctrine.md
└── reflection.md
```

If you are part of a cohort: push to a private GitHub repo and share access with the instructors.
If you are self-paced: save locally. The act of completing it matters more than submitting it.

---

## Why This Assignment Matters

Most courses ask you to read or watch. This one asks you to *operate*.

In 60 minutes, you will produce something real, document what you learned, and start the doctrine file that will compound into your most valuable career asset.

When you reach Session 5, you'll look back at this Session 1 doctrine and laugh at how thin it was. That's the point. The growth is the deliverable.

See you in Session 2.

— Ahmed
