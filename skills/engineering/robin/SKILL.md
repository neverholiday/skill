---
name: robin
description: Scan an undocumented codebase, generate CONTEXT.md and initial ADRs, review decisions via an interactive grilling session and an HTML report, plan, and implement code/doc changes. Use when you need to bootstrap documentation for an existing codebase and align its implementation.
---

# Robin (Domain Discovery & Documentation Bootstrap)

Robin is a custom engineering skill designed to bootstrap a codebase's documentation (specifically its domain glossary `CONTEXT.md` and Architectural Decision Records `docs/adr/`) and align its codebase with the developer's decisions.

It follows a 6-step loop to ensure a structured, collaborative, and precise discovery and alignment process.

---

## The 6-Step Robin Workflow

Follow this step-by-step checklist exactly when executing this skill:

### 1. Scan & Explore 🛰️
- `[ ]` **Explore Codebase Structure:** Use file and search tools (`list_dir`, `grep_search`) to map the repository.
- `[ ]` **Identify Core Components:** Inspect configuration files (e.g. `package.json`, `Cargo.toml`, `go.mod`), main entry points, databases, APIs, and critical business logic folders.
- `[ ]` **Discover Domain Language:** Take note of recurring concepts, key terms, classes, variables, and potential ambiguities in the code.

### 2. Draft & Report 📊
- `[ ]` **Draft Domain Docs:**
  - Create a first draft of `CONTEXT.md` using the format defined in [CONTEXT-FORMAT.md](../grill-with-doc/CONTEXT-FORMAT.md).
  - Draft initial Architectural Decision Records (ADRs) under `docs/adr/` capturing current tech choices and boundaries using the format defined in [ADR-FORMAT.md](../grill-with-doc/ADR-FORMAT.md).
- `[ ]` **Generate HTML Report:**
  - Create a beautifully styled, premium HTML report saved to `.antigravitycli/robin_scan_report.html` in the workspace.
  - The report must feature:
    - **Rich Aesthetics:** Modern dark mode or clean high-contrast color scheme, smooth gradients, crisp typography, and tables organizing discovered code elements.
    - **Inferred Architecture:** A summary of directories, files, technologies, and databases found.
    - **Proposed Glossary:** The list of drafted domain terms, their definitions, and aliases to avoid.
    - **Proposed ADRs:** Summaries of identified architectural choices.
  - Present the report link to the developer to open in their browser (e.g. `[Scan Report](file:///<absolute-path-to-file>)`).

### 3. Interactive Grilling 💬
- `[ ]` **Start the Interview:**
  - Go through the proposed glossary terms and ADRs one by one.
  - Challenge ambiguous terms or contradictions between code and documentation.
  - Recommend clear definitions and get explicit feedback/corrections from the developer.
- `[ ]` **Final Feedback Check:**
  - *Crucial:* Before ending the grilling session, explicitly ask the developer: *"Is there anything else you want to adjust, add, or decide before we conclude the grilling session and plan the changes?"*
  - Update `CONTEXT.md` and ADRs inline to reflect all resolved decisions.

### 4. Plan Changes 📋
- `[ ]` **Formulate Implementation Plan:**
  - Identify any discrepancies between the developer's decisions and the actual codebase.
  - Design the refactoring or modifications needed to align the code with the glossary and decisions.
  - Present this plan clearly to the developer for approval.

### 5. Edit & Implement 💻
- `[ ]` **Apply Edits:**
  - With the developer's approval, modify the codebase in small, vertical slices.
  - Keep code changes strictly aligned with the glossary (`CONTEXT.md`) and decisions (`docs/adr/`).
  - Refine documentation if any minor details evolve during implementation.

### 6. Verify & Done 🏁
- `[ ]` **Verification:**
  - Run tests, compile, or execute live verification to ensure the codebase remains functional and correct.
  - Present the final results to the developer.
- `[ ]` **Summarize & Suggest Commit:**
  - Output a concise summary of the bootstrapped documentation and code changes.
  - Recommend a clean, precise Conventional Commit message.
