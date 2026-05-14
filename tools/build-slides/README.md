# build-slides

Reusable slide-building helpers. Placeholder — full implementation in a future session.

## Why this exists

Session 1's slides are built in the **neon dev** aesthetic — Calibri typography, neon accent colors, no AI-generated stock imagery. Holding this look across Sessions 2–5 by hand is brittle. This folder will host:

- `neon-theme.js` — the reusable theme as PPTX XML / pptxgenjs config
- `build-session.js` — a Node script that takes a session's outline + theme and produces `slides.pptx`
- `verify-slides.py` — quick sanity check that every slide follows the 1-idea-per-slide rule

## How it will fit

```bash
# Build slides for Session 2 from its outline
node tools/build-slides/build-session.js sessions/session-02-defense

# Optional — verify slide density
python3 tools/build-slides/verify-slides.py sessions/session-02-defense/public/slides.pptx

# Convert to PDF for distribution
libreoffice --headless --convert-to pdf --outdir sessions/session-02-defense/public \
  sessions/session-02-defense/public/slides.pptx
```

For now, slides are built directly in PowerPoint/Keynote using the neon style established in Session 1.

---

[← Tools](../README.md)
