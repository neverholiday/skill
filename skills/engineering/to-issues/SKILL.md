---
name: to-issues
description: Read docs/prd.md and generate atomic local markdown issue files under docs/issues/. Appends/updates a bi-directional traceability table at the bottom of the PRD.
---

# Issue Breakdown Skill (to-issues)

This skill guides the AI Agent to parse the PRD (`docs/prd.md`), break it down into modular developer tasks, generate individual markdown issues in `docs/issues/`, and update the PRD's **Issues & Tasks** section to establish bi-directional traceability.

## Quick Start

1. Ensure `docs/prd.md` has been successfully generated.
2. Tell the AI:
   - *"Run the to-issues skill on docs/prd.md to generate developer tickets"*

---

## Workflow

### 1. Parse the PRD
The AI Agent scans `docs/prd.md` (whether personal or workplace mode) to identify key functional requirements, user flows, and technical tasks (including backend, database, APIs, security, and the newly added monitoring/observability).

### 2. Formulate Atomic Issues
Break down the requirements into **atomic developer tasks**. A task is atomic if it:
- Can be completed in less than 1-2 days by a single developer or agentic coder.
- Has a clear definition of success.
- Focuses on a single subsystem (e.g., database schema vs. API endpoint vs. frontend UI).

### 3. Generate Issue Markdown Files
For each task, create a markdown file in the `docs/issues/` folder. Use sequential numbering (e.g., `0001-xxx.md`, `0002-xxx.md`).
Each issue must strictly use the structure defined in `skills/engineering/to-issues/templates/issue-template.md`:
- **YAML Frontmatter:** Containing a unique ID, short title, target PRD section link (e.g., `docs/prd.md#31-login-flow`), assignee, and status (`todo`, `in_progress`, `done`).
- **Description:** A clear explanation of what needs to be built and why.
- **Acceptance Criteria Checklist:** A checklist detailing the specific checkboxes that must be ticked to consider the issue complete.

### 4. Create Bi-directional PRD Reference
Once all issues are written to `docs/issues/`, the AI Agent must append or update an **Issues & Tasks** table at the bottom of `docs/prd.md`:

```markdown
## Issues & Tasks

| Issue ID | Title | PRD Section | File Link | Status |
| :--- | :--- | :--- | :--- | :--- |
| `TASK-0001` | Setup SQLite Database Schema | [Section 4.1: Database](#41-database-schema) | [0001-setup-sqlite.md](issues/0001-setup-sqlite.md) | `todo` |
| `TASK-0002` | Implement Login UI Page | [Section 3.1: Login Flow](#31-login-flow) | [0002-login-ui.md](issues/0002-login-ui.md) | `todo` |
```

---

## Guidelines for the AI Coder

1. **Self-Contained Issues:** Each issue should contain enough context for an agentic coder to execute the task without needing to continuously refer back to other files, except for the PRD.
2. **Traceability First:** Every issue must contain a valid markdown anchor link pointing to the exact header/section of the PRD (`prd_link: "docs/prd.md#..."`).
3. **No Overlaps:** Ensure distinct boundaries between tasks so that multiple AI agents or developers could theoretically work on different issues in parallel without massive git conflicts.
