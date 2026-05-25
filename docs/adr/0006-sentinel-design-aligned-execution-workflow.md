# 0006. Sentinel Design-Aligned Execution and Live-Verification Workflow

**Status:** accepted

We decided to design a custom skill named **Sentinel** to govern all code implementations and refactorings within the workspace. Sentinel acts as a Design-Aligned Execution guardrail and orchestrates the Live-Environment Verification feedback loop, allowing the developer to run either with a formalized Task file or through ad-hoc requests without losing context or quality.

### Context and Trade-offs

- **Flexibility vs. Rigidity (Task-less Execution):** Strictly forcing the AI agent to only work inside pre-defined Task files creates excessive friction during fast prototyping. Sentinel supports an "Ad-hoc Mode" which enables the developer to propose arbitrary changes directly, while guaranteeing the agent remains structurally aligned with the codebase's architecture and language.
- **Guardrailed by Context & Design:** To prevent the common AI agent anti-pattern of "context drift," Sentinel enforces a mandatory pre-flight alignment check. The agent must verify that any planned implementation or terminal command aligns with the domain terminology in `CONTEXT.md`, architectural patterns in system-wide/context-specific `docs/adr/`, and product requirements in `docs/prd.md`.
- **Live-Environment Verification Feedback Loop:** Local unit testing is often insufficient for verifying custom agent skills running in sandbox environments. Sentinel automatically executes the workspace's deployment script (`./scripts/install.sh`), provides clear manual verification guidelines, and enters an interactive "Verification Listening Mode" to consume raw execution logs and console stack traces to iteratively resolve bugs before marking the execution complete.
- **Bi-directional Status & Dashboard Sync:** When running in Task mode, Sentinel automates the tedious bookkeeping chores of setting assignee names, updating task status frontmatter (`todo` -> `in_progress` -> `done`), and rebuilding the central `docs/tasks/README.md` dashboard index and `docs/prd.md` checklist table.
