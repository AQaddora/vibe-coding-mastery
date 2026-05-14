# Runs Registry Schema — Reference

> **Status:** TODO — finalize schema and indexing in a future session.

## Storage Layout

```
~/.vibe-coding/
├── runs/                      ← global runs
│   ├── exec-2026-05-13-jwt-refactor.md
│   ├── exec-2026-05-13-add-search.md
│   └── …
└── index.jsonl                ← append-only index for fast filtering

<project>/runs/                ← project-scoped runs
├── exec-2026-05-13-jwt-refactor.md
└── …
```

## Runfile Schema — TODO

- [ ] Required fields: id, goal, agent, started_at, status, primer_ref, acceptance_criteria
- [ ] Optional fields: tags, doctrine_links, refine_pattern, branch, commit_range
- [ ] Status enum: in_progress | completed | failed | abandoned
- [ ] Tags vocabulary: TODO — define controlled set vs free-form

## Index Schema — TODO

- [ ] Append-only JSONL for fast scans
- [ ] One record per run, one record per status change
- [ ] Fields indexed for grep: id, agent, status, tags, doctrine_links

## Privacy — TODO

- [ ] Runfiles default to .gitignore in projects
- [ ] Global runs (~/.vibe-coding/) never enter source control
- [ ] Export tool — TODO — for sharing sanitized runs with the team
