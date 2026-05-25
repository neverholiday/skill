---
name: sentinel
description: Design-aligned execution and live-environment verification workflow. Ensures all code changes are strictly guardrailed by the glossary, ADRs, and PRD, and verified in a live environment. Use when the user wants to build a feature, fix a bug, execute a task, or do general coding.
---

# Sentinel (Design-Aligned Execution)

Sentinel is a custom execution skill designed to keep code modifications and refactorings perfectly aligned with the project's **domain glossary (`CONTEXT.md`)**, **Architectural Decision Records (`docs/adr/`)**, and **requirements (`docs/prd.md`)**, while guaranteeing rigorous validation via **`Live-Environment Verification`**.

## Philosophies & Stances

To maximize code stability and architectural integrity, Sentinel operates under three core principles:
*   **The Guardrail Stance:** Never write a line of code or propose a design without first scanning `CONTEXT.md` and `docs/adr/`. All proposed functions, interfaces, and terms must align with the glossary. Never allow conceptual or terms drift.
*   **Small Vertical Slices:** Avoid "The Giant Leap" (writing massive, sprawling changes across multiple files without testing). Implement changes in small, testable, and cohesive slices.
*   **Live-First Verification:** A change is not complete simply because it compiles or passes mock tests. Real-world execution is the gold standard. You must deploy/install your changes live and iteratively resolve runtime errors.

---

## Operating Modes

Sentinel dynamically adapts based on how it is invoked:

### 1. Task-Driven Mode
*   **Trigger:** `/sentinel TASK-XXXX` or `/sentinel docs/tasks/XXXX-file.md`
*   **Focus:** Focused execution of a specific backlog item, complete with automated metadata tracking and dashboard updates.

### 2. Ad-hoc Mode
*   **Trigger:** `/sentinel [description of change]` or just executing code updates directly under Sentinel guidelines.
*   **Focus:** Fast, flexible feature additions or bug fixes without the overhead of a rigid Task file, while keeping the guardrails fully active.

---

## Sentinel Execution Workflow

Follow this step-by-step checklist exactly during execution:

### 1. Pre-flight Alignment Check 🛰️
- `[ ]` Read `CONTEXT.md` in full.
- `[ ]` Scan all decision documents under `docs/adr/` (and context-specific folders if they exist).
- `[ ]` Review the active product spec at `docs/prd.md`.
- `[ ]` **Concept & Glossary Check:** Evaluate if the planned work, files, or terms conflict with existing architectural patterns or terms definitions.
  - *If a conflict is detected:* Stop immediately. Raise a clear warning to the developer (e.g. *"Your glossary defines X as Y, but this request assumes Z. How should we proceed?"*).

### 2. Initialize Execution State 📋 *(Task-Driven Mode Only)*
- `[ ]` Open the target task markdown file under `docs/tasks/`.
- `[ ]` Update the YAML frontmatter:
  - Transition `status` from `todo` to `in_progress`.
  - Set `assignee` to the name of the active AI agent (e.g. `"antigravity"`).
- `[ ]` Run the task compiler to rebuild the central `docs/tasks/README.md` dashboard, ensuring the progress is synced immediately.

### 3. Implement in Vertical Slices 💻
- `[ ]` Code the feature or fix in highly cohesive, iterative stages.
- `[ ]` Write corresponding unit or integration tests as you go.
- `[ ]` Ensure each slice resolves exactly one part of the requirement without leaking into unrelated domains or files.

### 4. Live-Environment Verification & Feedback Loop 🔄
- `[ ]` **Deploy/Install:** Execute the repository's installation script (typically `./scripts/install.sh`) to link, build, or deploy your changes to the target developer environment.
- `[ ]` **Print Test Checklist:** Output a clear, step-by-step checklist under a prominent header: **`Live Verification Instructions`**. Detail exactly how the developer can manually run, trigger, or stress-test the changes.
- `[ ]` **Verification Listening Mode:** Enter a listening state. Instruct the developer to run the tests and paste any errors, stack traces, logs, or behavioral quirks.
- `[ ]` **Iterative Debugging:** If the developer pastes errors or stack traces:
  - Deep-dive into the logs to diagnose root causes (e.g., file permissions, environment variables, interface mismatches).
  - Apply targeted hot-fixes.
  - Re-run `./scripts/install.sh` and ask the developer to test again.
  - Loop until the developer explicitly confirms the implementation is fully working (e.g. *"It works!"*).

### 5. Finalize & Sync Backlog 🏁
- `[ ]` **Complete Task:** *(Task-Driven Mode Only)*
  - Open the target task markdown file and check off the completed items in the **Acceptance Criteria** checklist.
  - Transition `status` in the frontmatter to `done`.
  - Rebuild the `docs/tasks/README.md` task index dashboard.
  - Update the PRD's bottom checklist table.
- `[ ]` **Summarize & Suggest Commit:**
  - Print a concise bulleted summary of the verified capabilities.
  - Suggest a clean, precise Conventional Commit message reflecting the changes made.
