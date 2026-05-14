# Tools

Repo automation helpers — for the maintainer (Ahmed) and contributors.

## What's here

| Tool | Purpose |
| --- | --- |
| `new-session.sh` | Scaffold a new session folder with the standard public/private layout |
| `build-slides/` | Reusable slide-building helpers — neon-theme + per-session compositor (TODO) |

## `new-session.sh`

Creates the standard scaffolding for a new pre-course session:

```bash
./tools/new-session.sh 02 defense "Get the Best From AI Tools (Without Getting Burned)"
```

Generates `sessions/session-02-defense/` with the public/private split, placeholder READMEs in both repos, and the standard file slots (slides, practical, assignment, references, terminology in public; scripts, teleprompter, role notes in private).

Re-running on an existing session is a no-op for files that already exist (won't overwrite Ahmed's content).

## `build-slides/`

Placeholder. Future home for:

- `neon-theme.js` — reusable PPTX theme (Calibri + neon accents, the slide aesthetic locked in Session 1)
- `build-session.js` — compositor that takes a session script + theme and outputs `slides.pptx`

Today, slides are built by hand in PowerPoint/Keynote. The build-slides tool will automate the look across Sessions 2–5 so they stay visually consistent.

---

[← Back to repo root](../README.md)
