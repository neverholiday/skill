# 0004. Devil's Advocate Interactive Grilling Skill

**Status:** accepted

We decided to design the custom `devils-advocate` skill to run as an interactive, sequential "grilling" session rather than a static report. When manually triggered on a target file or plan, the skill automatically detects the input type (Code, Configuration, or Plan/PRD) and applies context-aware checklists to identify blind spots, race conditions, security risks, or architectural lock-in, exposing challenges one-by-one and waiting for user feedback before proceeding.

### Context and Trade-offs
- **High Engagement vs. Static Overhead:** While a static report is faster to generate, it often leads to passive reading or analysis paralysis. The sequential "grilling" style forces active defense and iteration on each vulnerability, resulting in a significantly more robust codebase/design.
- **Context-Aware Checklists:** Creating custom check matrices for different file types ensures highly relevant feedback. Code files are checked for runtime vulnerabilities, configurations for environment/credential leakages, and plans for logical gaps/biases.
- **Single-Turn Limitation Mitigation:** By structuring the skill as an interactive dialog, the agent can guide the user through complex refactoring, treating the session as a shared, step-by-step collaborative improvement process.
