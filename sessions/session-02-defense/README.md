# Session 2 — Get the Best From AI Tools (Without Getting Burned)

> *"In 2026 the moat isn't 'I know how to prompt'. It's 'I know how AI breaks — and I have a system to catch it before production does.'"*

**Status:** ⏳ In production
**Runtime:** 30 minutes (target)
**Cost:** Paid (part of the pre-course bundle)

## The promise

By the end of this session you'll have a working defense system against the 7 hidden failure modes that bite AI-assisted developers in production: hallucinated APIs, version-mismatched code, leaked tenant data, silent vulnerabilities, slopsquatted packages, async-mixed-with-sync deadlocks, and prompt injection through agentic tools.

## The trap discussed

Treating an AI suggestion as code review. It isn't. AI's confidence is uncorrelated with correctness, and most of its failures are quiet — they ship, they run for a while, and then a customer or an auditor finds them.

## What you walk away with

- The **7 Failures Checklist** — print it, tape it next to your monitor
- A **threat-model template** you paste at the end of any AI session that touches auth, payments, or user data
- A **Refine prompt library** — counter-prompts that catch each failure mode
- New entries for your `ai-doctrine.md` covering the defense patterns

## Production notes

Slides, script, practical, assignment, references, and terminology will land in `public/` when production completes. Production-side scripts and teleprompter will live in the private repo.

---

[← All sessions](../README.md) · [Session 1](../session-01-mindset/README.md)
