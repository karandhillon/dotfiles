---
description: Simplify the wording of a PR description, keeping its layout intact
argument-hint: <PR number or URL>
---
Fetch the PR description for: $1 (use `gh pr view` — repo is inferred from the current directory's git remote).

Rewrite it by simplifying the wording only:
- Keep the exact same structure, section headings, markdown formatting, and order
- Preserve all factual content: ticket IDs, numbers, links, commands, checklists
- Do not add, remove, or reorder sections; do not editorialize
- Cut fluff, filler phrases, and redundant sentences; tighten wordy phrasing
- Keep it skimmable — short sentences and bullets where they already exist

Output the full simplified description first, then immediately update the PR with
`gh pr edit` (pipe the new body via a heredoc + `--body-file -`). No confirmation needed.
