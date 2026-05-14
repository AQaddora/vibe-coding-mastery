# Runfile Format — Reference

> **Status:** TODO — fill in annotated examples in a future session.

## Canonical Template

```markdown
# Run [id]

- **Goal:** [one sentence from comprehension brief]
- **Agent:** [claude-code | cursor | codex | aider | gemini-cli | other]
- **Started:** [ISO datetime]
- **Primer source:** [~/ai-doctrine.md sections referenced]
- **Refine pattern:** [reviewer role(s) used during planning]
- **Acceptance criteria:** [explicit checklist — agent must satisfy all]
- **Status:** [in_progress | completed | failed | abandoned]

## Files in scope
- path/to/file.py
- path/to/other.ts

## Constraints
- [perf, security, compat]

## Output
[Filled in after agent completes — diff summary, files touched, tests added, any deviations from brief]

## Lessons
[Filled in at close — doctrine candidates]
```

## Run ID Convention — TODO

- [ ] Format: `exec-YYYY-MM-DD-<slug>`
- [ ] Slug: short, kebab-case, action verb if possible
- [ ] Examples: `exec-2026-05-13-jwt-refactor`, `exec-2026-05-14-add-search`

## Agent Invocation Patterns — TODO

- [ ] Claude Code — full runfile as system message
- [ ] Cursor agent — paste runfile, mention the branch
- [ ] Codex CLI — `codex run -f <runfile>`
- [ ] Aider — `aider --message "$(cat <runfile>)"`
- [ ] Gemini CLI — TODO
