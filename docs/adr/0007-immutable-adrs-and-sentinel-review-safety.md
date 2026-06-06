# 0007. Immutable ADRs and Sentinel Review Safety

**Status:** accepted

We decided to enforce immutable Architectural Decision Records (ADRs) and introduce strict developer review checkpoints in the Sentinel execution flow.

### Context and Trade-offs

- **Immutable ADRs:** Modifying existing, accepted ADRs historically can corrupt context and hide the evolutionary design choices of the project. To prevent this, all new decisions must be captured in new, sequentially numbered ADRs. If a previous decision is superseded or deprecated, only its `status` frontmatter should be updated (e.g., `superseded by ADR-0007`) without altering the historical core text.
- **RCA-first Debugging Flow:** Automatically applying bug fixes without explicit developer consent often introduces regression or drift. Sentinel will now mandate that if any error or failure is encountered during execution, the agent must perform a Root Cause Analysis (RCA), present the findings and a proposed fix to the developer, and wait for explicit approval before modifying files or proceeding.
- **Task Verification Checkpoint:** Sentinel previously marked tasks as `done` and updated the index automatically upon completing implementation. To ensure proper human-in-the-loop validation, Sentinel will now keep tasks in `in_progress` status until the developer explicitly reviews the changes and grants permission to proceed, after which Sentinel will transition the task to `done` and update the backlog.
