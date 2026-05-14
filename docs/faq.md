# FAQ

## About the framework

### What is PURE?

**P**rime → **U**nderstand → **R**efine → **E**xecute. A four-phase protocol for running any task through AI coding tools. The phases enforce the discipline that turns AI from autocomplete into a real pair: load context first, clarify scope second, review before generating, then delegate cleanly with verification.

See [`skills/pure-orchestrator/SKILL.md`](../skills/pure-orchestrator/SKILL.md) for the full protocol.

### What is the AI Doctrine?

A single file (`~/ai-doctrine.md`) on your machine that captures every rule, primer, and lesson you've learned from working with AI. Categorized by PURE phase plus a fifth bucket for failure modes (Trap).

The doctrine is symlinked into every AI tool's config (Claude Code, Cursor, Copilot, Codex, Gemini CLI, Windsurf) so the same memory follows you across tools.

### Why is this different from just writing a prompt template?

A prompt template is one-shot. The AI Doctrine compounds — each session adds new rules, deprecates old ones, and the file gets smarter over months and years. After 6 months of use, your doctrine is more valuable than any prompt repo you'll find online because it's specific to *your* stack, *your* style, and the bugs *you* keep catching.

### Did Ahmed invent PURE and AI Doctrine?

Yes. The framework was developed in production from real founder/agency/teaching work and is the core IP of the Vibe Coding Mastery curriculum. The names and the protocol are credited to Ahmed Qaddoura. The skill implementations are MIT licensed — fair use of the framework names is welcome with attribution.

## About the course

### Why is Session 1 free?

It's the on-ramp. The framework introduced in Session 1 (PURE + AI Doctrine) is the load-bearing column under the entire pre-course and the 15-session main course. Giving it away costs nothing and earns trust. Sessions 2–5 are paid because that's where the system gets weaponized — defending against AI failure modes, shipping MVPs, building trusted SaaS, automating careers.

### Who is this course for?

Developers (junior to mid-level) who want career leverage from AI. Technical founders and freelancers who can code a bit and want to ship. Career switchers and ambitious students with basic coding ability.

You should be comfortable with a code editor, understand what an API is, and have shipped at least one thing (even a static site).

### Is the course in English or Arabic?

The slides and source scripts are written in English. The recorded delivery is in Arabic (Ahmed's primary teaching language). English subtitles will be provided.

### When do Sessions 2–5 launch?

In production now. Mailing list at [aqaddoura.com](https://aqaddoura.com) — you'll get a heads-up when each session ships.

## About the skills

### Do the skills work with tools other than Claude?

The `SKILL.md` format is Claude-native (Claude reads skills from `~/.claude/skills/`). But the **AI Doctrine** that the skills write to is plain Markdown, symlinked into every AI tool's config file. So:

- Claude Code, Cursor, Copilot, Codex, Gemini CLI, Aider, Windsurf — all read the doctrine, all benefit from the rules
- Only Claude triggers the *skills* themselves automatically (the prime/understand/refine/etc. invocations)
- For non-Claude tools, you can still invoke the protocol manually by following the SKILL.md instructions yourself

In practice: you build your rules in Claude using the skills, then every other tool reads them via the symlinked doctrine.

### Do I need Claude Code installed?

No. The skills install into `~/.claude/skills/` which is read by claude.ai's web app, Claude desktop, and Claude Code. Any of them will trigger the skills automatically based on your prompts.

### Can I customize a skill?

Yes — MIT license. Fork the repo, modify `SKILL.md`, reinstall with `./skills/install.sh`. Or open a PR if you think your change should be upstream.

### Can I add my own skills?

Yes. Add a folder under `skills/`, follow the structure of an existing skill (`SKILL.md` + `references/` + `scripts/`), and your skill will be picked up by `install.sh` automatically.

### What if I don't want all 7 skills?

Run `./skills/install.sh`, then `rm -rf ~/.claude/skills/<skill-name>` for any you don't want. The orchestrator works best with all 7 but each skill can be used standalone.

## Privacy & licensing

### Where does my doctrine get stored?

`~/ai-doctrine.md` lives on **your machine only**. Nothing is sent anywhere. Symlinks point at it from your project folders so AI tools can read it locally.

### Is my doctrine shared with Anthropic / OpenAI / etc.?

Only in the sense that any prompt you send to an AI tool includes whatever rules the tool's config file points at. If you don't want a specific rule sent to a specific provider, don't symlink the doctrine into that tool's config file.

### Can I use the PURE framework in my own teaching?

Yes — with credit. The framework is open to reference, build on, and teach. Just don't strip attribution or rebrand the names.

### What about the course content?

`sessions/*/public/` is **All Rights Reserved** — read and apply for personal learning, do not republish or use to produce competing courses. See [LICENSE](../LICENSE).

---

[← Documentation index](index.md) · [Repo root](../README.md)
