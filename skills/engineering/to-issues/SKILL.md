---
name: to-issues
description: Read docs/prd.md, generate atomic markdown issue files under docs/issues/, and compile a progress-tracking Issue Index (README.md) with story points effort estimation.
---

# Issue Breakdown Skill (to-issues)

This skill guides the AI Agent to parse the PRD (`docs/prd.md`), break it down into modular developer tasks, generate individual markdown issues in `docs/issues/`, update the PRD's **Issues & Tasks** section, and compile a central **Issue Index** (`docs/issues/README.md`) tracking overall progress and effort (story points).

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
- **YAML Frontmatter:** Containing a unique ID, short title, target PRD section link (e.g., `docs/prd.md#31-login-flow`), assignee, status (`todo`, `in_progress`, `done`), and estimate (story points).
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

### 5. Compile the Issue Index

Once all issues are created or updated, the AI Agent must compile or update the central **Issue Index** at `docs/issues/README.md`.

The Issue Index must serve as a visual dashboard, using the individual markdown files in `docs/issues/*.md` as the single source of truth for metrics and grouping.

#### Metrics Calculation Rules
- **Total Tasks:** The total number of issue markdown files under `docs/issues/` (excluding `README.md`).
- **Completed Tasks:** The count of tasks with `status: "done"`.
- **Total Story Points:** Sum the `estimate` field across all task files.
- **Completed Story Points:** Sum the `estimate` field of all tasks whose `status` is `done`.
- **Completion Percentage:** Calculate both task and story point completion percentages rounded to the nearest integer.

#### Layout Structure Template
The `docs/issues/README.md` must strictly adhere to the following template:

```markdown
# Issue Index

[← Back to Product Requirement Document](../prd.md)

Welcome to the central tracking index for this project. This dashboard is programmatically generated and updated by the `to-issues` skill from the individual task files located in this directory.

**Source PRD:** [docs/prd.md](../prd.md)

## 📊 Project Progress

| Metric | Value |
| :--- | :--- |
| **Total Tasks** | {Total Count} |
| **Completed Tasks** | {Done Count} / {Total Count} ({Task Percentage}%) |
| **Total Story Points** | {Total Points} |
| **Completed Story Points** | {Done Points} / {Total Points} ({Points Percentage}%) |

---

## 🏃 In Progress
*Tasks currently being actively worked on.*

| Issue ID | Title | Assignee | Estimate | PRD Section | Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-0002` | Setup SQLite Database Schema | `nashay` | `3` | [Section 4.1](#41-database-schema) | [0002-setup-sqlite.md](./0002-setup-sqlite.md) |

## 📋 Todo
*Tasks waiting to be started.*

| Issue ID | Title | Assignee | Estimate | PRD Section | Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-0001` | Setup Project Boilerplate | `unassigned` | `2` | [Section 1](#1-intro) | [0001-setup-project.md](./0001-setup-project.md) |

## ✅ Done
*Completed tasks.*

| Issue ID | Title | Assignee | Estimate | PRD Section | Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-0003` | Define API Types | `nashay` | `1` | [Section 2.1](#21-api) | [0003-define-api-types.md](./0003-define-api-types.md) |
```

---

## Guidelines for the AI Coder

1. **Self-Contained Issues:** Each issue should contain enough context for an agentic coder to execute the task without needing to continuously refer back to other files, except for the PRD.
2. **Traceability First:** Every issue must contain a valid markdown anchor link pointing to the exact header/section of the PRD (`prd_link: "docs/prd.md#..."`).
3. **No Overlaps:** Ensure distinct boundaries between tasks so that multiple AI agents or developers could theoretically work on different issues in parallel without massive git conflicts.
4. **Effort Estimation:** Proactively assign story points to the `estimate` field in the frontmatter using the standard Fibonacci sequence (1, 2, 3, 5, 8) based on complexity and risk.
5. **Dynamic Compilation:** Always rebuild the `Issue Index` (`docs/issues/README.md`) from scratch whenever issues are created or modified to ensure it remains perfectly in sync.
