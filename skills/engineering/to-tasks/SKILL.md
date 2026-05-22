---
name: to-tasks
description: Read docs/prd.md, generate atomic markdown task files under docs/tasks/ with user story traceability, and compile a central progress dashboard (README.md).
---

# Task Breakdown Skill (to-tasks)

This skill guides the AI Agent to parse the PRD (`docs/prd.md`), break it down into modular developer tasks, generate individual markdown task files in `docs/tasks/` with user story mapping, update the PRD's **Tasks & Checklist** section, and compile a central **Task Index** (`docs/tasks/README.md`) tracking overall progress, effort (story points), and user story traceability.

## Quick Start

1. Ensure `docs/prd.md` has been successfully generated using the unified PRD template.
2. Tell the AI:
   - *"Run the to-tasks skill on docs/prd.md to generate developer tasks"*

---

## Workflow

### 1. Parse the PRD & User Stories
The AI Agent scans `docs/prd.md` to identify:
- Key functional requirements, user flows, and technical decisions.
- All User Stories listed under the `## User Stories` section, extracting their explicit IDs (e.g. `[US-1]`, `[US-2]`, etc.).

### 2. Formulate Atomic Tasks
Break down the requirements into **atomic tasks**. A task is atomic if it:
- Can be completed in less than 1-2 days by a single developer or agentic coder.
- Has a clear definition of success.
- Focuses on a single subsystem (e.g., database schema vs. API endpoint vs. frontend UI).

### 3. Quiz the User
Before generating any task markdown files, the AI Agent must present the proposed task breakdown to the user in a clean, high-level summary table.

#### Rules for the Quiz
1. **Focus on Local Attributes**: Focus strictly on the following task attributes:
   - **Task ID**: Sequential IDs starting from `TASK-0001`.
   - **Title**: A concise, descriptive name of the task.
   - **Estimate**: Fibonacci story points (1, 2, 3, 5, 8) based on complexity and risk.
   - **User Stories**: Traced User Stories (e.g., `US-1`, `US-2`).
   - **PRD Section**: The target header/anchor in the PRD.
   - **Assignee**: Defaults to `"unassigned"`.
   Do not introduce external concepts like `HITL`/`AFK` classifications.
2. **Handle Creation and Updates**:
   - **For new task breakdowns**: Present all proposed tasks.
   - **For updates to existing breakdowns**: Mark each proposed task with one of the following state tags:
     - `[NEW]`: Task is new and needs to be created.
     - `[MODIFIED]`: Existing task whose metadata (title, estimate, etc.) is being updated.
     - `[DELETED]`: Existing task that is no longer needed.
     - `[UNTOUCHED]`: Existing task that remains unchanged.
3. **Iterative Refinement**:
   - Explicitly ask the user if the granularity of the breakdown is correct, if the estimates are reasonable, and if the story mappings are correct.
   - If the user requests changes (e.g., splitting a task, changing an estimate, or renaming), update the proposed plan, re-sequence the task IDs if needed, and present the updated high-level summary.
   - Wait for explicit user approval (e.g., "Approved" or "Looks good") before proceeding to file generation.

### 4. Generate Task Markdown Files
For each task, create a markdown file in the `docs/tasks/` folder. Use sequential numbering (e.g., `0001-xxx.md`, `0002-xxx.md`).
Each task must strictly use the structure defined in `skills/engineering/to-tasks/templates/task-template.md`:
- **YAML Frontmatter:** Containing a unique ID (`id`), title (`title`), link to target PRD section (`prd_link`), mapping to implemented User Stories (`user_stories: ["US-1", "US-2"]`), assignee (`assignee`), status (`todo`, `in_progress`, `done`), and effort estimate in story points (`estimate`).
- **Description:** A clear explanation of what needs to be built and why.
- **Acceptance Criteria Checklist:** A checklist detailing the specific checkboxes that must be ticked to consider the task complete.

### 5. Create Bi-directional PRD Reference
Once all tasks are written to `docs/tasks/`, the AI Agent must append or update a **Tasks & Checklist** table at the bottom of `docs/prd.md`, including user story tracing:

```markdown
## Tasks & Checklist

| Task ID | Title | User Stories | PRD Section | File Link | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-0001` | Setup SQLite Database Schema | `US-1`, `US-2` | [Section 4: Implementation Decisions](#implementation-decisions) | [0001-setup-sqlite.md](tasks/0001-setup-sqlite.md) | `todo` |
| `TASK-0002` | Implement Login UI Page | `US-3` | [Section 4: Implementation Decisions](#implementation-decisions) | [0002-login-ui.md](tasks/0002-login-ui.md) | `todo` |
```

### 6. Compile the Task Index Dashboard

Once all tasks are created or updated, the AI Agent must compile or update the central **Task Index** at `docs/tasks/README.md`.

The Task Index must serve as a visual dashboard, using the individual markdown files in `docs/tasks/*.md` as the single source of truth for metrics, groupings, and story mapping.

#### Metrics Calculation Rules
- **Total Tasks:** The total number of task markdown files under `docs/tasks/` (excluding `README.md`).
- **Completed Tasks:** The count of tasks with `status: "done"`.
- **Total Story Points:** Sum the `estimate` field across all task files.
- **Completed Story Points:** Sum the `estimate` field of all tasks whose `status` is `done`.
- **Completion Percentage:** Calculate both task and story point completion percentages rounded to the nearest integer.

#### Layout Structure Template
The `docs/tasks/README.md` must strictly adhere to the following template:

```markdown
# Task Index

[← Back to Product Requirement Document](../prd.md)

Welcome to the central tracking index for this project. This dashboard is programmatically generated and updated by the `to-tasks` skill from the individual task files located in this directory.

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

| Task ID | Title | Assignee | Estimate | User Stories | Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-0002` | Setup SQLite Database Schema | `nashay` | `3` | `US-1`, `US-2` | [0002-setup-sqlite.md](./0002-setup-sqlite.md) |

## 📋 Todo
*Tasks waiting to be started.*

| Task ID | Title | Assignee | Estimate | User Stories | Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-0001` | Setup Project Boilerplate | `unassigned` | `2` | `US-1` | [0001-setup-project.md](./0001-setup-project.md) |

## ✅ Done
*Completed tasks.*

| Task ID | Title | Assignee | Estimate | User Stories | Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-0003` | Define API Types | `nashay` | `1` | `US-3` | [0003-define-api-types.md](./0003-define-api-types.md) |
```

---

## Guidelines for the AI Coder

1. **Self-Contained Tasks:** Each task file should contain enough context for an agentic coder to execute the task without needing to continuously refer back to other files, except for the PRD.
2. **Traceability First:** Every task must contain a valid markdown anchor link pointing to the exact header/section of the PRD (`prd_link: "docs/prd.md#..."`) and explicit list of traced User Stories (`user_stories: ["US-X"]`).
3. **No Overlaps:** Ensure distinct boundaries between tasks so that multiple AI agents or developers could theoretically work on different tasks in parallel without massive git conflicts.
4. **Effort Estimation:** Proactively assign story points to the `estimate` field in the frontmatter using the standard Fibonacci sequence (1, 2, 3, 5, 8) based on complexity and risk.
5. **Dynamic Compilation:** Always rebuild the `Task Index` (`docs/tasks/README.md`) from scratch whenever tasks are created or modified to ensure it remains perfectly in sync.
