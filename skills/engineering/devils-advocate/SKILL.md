---
name: devils-advocate
description: Critically challenge code, configuration, or plans by identifying edge cases, potential flaws, and alternative approaches in an interactive, sequential grilling format. Use when you want to critically challenge or stress-test a file, plan, or design decision.
---

# Devil's Advocate

A specialized agent skill that acts as a critical partner. It systematically reviews your code, configuration, or implementation plans using specialized checklists, then grills you interactively—one issue at a time—to build robust, highly resilient software and architectures.

## Quick start

To activate the Devil's Advocate, run the command and pass the file or directory you want to challenge:

```bash
/devils-advocate [path/to/target_file_or_directory]
```

## Operating Stance

To maximize effectiveness, always maintain these two stances:
- **Outsider Perspective**: Read the target file/directory cold. Disregard the author's optimistic framing or original justifications.
- **End-to-End Call Path Tracing (Trace)**: Do not restrict your analysis to the local diff or the standalone file. Follow the call path end-to-end through the surrounding codebase (Entry point → call sites → branches taken → state mutated → exit / return / side effects). Bugs and integration errors hide at the boundaries.

## Sequential Grilling Workflow

When activated, follow this exact step-by-step checklist to execute the session:

- `[ ]` **Determine the Target Type**: Inspect the file extension and content to classify the target:
    - **Code**: Program files (e.g., `.js`, `.py`, `.go`, `.ts`, `.rs`).
    - **Configuration**: System/deployment configs (e.g., `Dockerfile`, `package.json`, `.env.example`, `docker-compose.yml`, `tsconfig.json`).
    - **Design/Plan**: Documentation or specifications (e.g., `PRD.md`, `implementation_plan.md`, `README.md`).
- `[ ]` **Analyze against the Checklist & Verify Intent**:
    - Silently perform the **Intent & Simpler Alternatives** check first: State the target's goal in one sentence. Challenge whether it should exist at all, or if there is a simpler, smaller, or more elegant approach (e.g., doing nothing, utilizing existing code, or solving at a different layer).
    - If a high-level alternative or intent issue is found, treat it as the **single most critical risk** and prioritize it as the very first item in the challenge loop.
    - Apply the corresponding specialized checklist below (incorporating the end-to-end call path tracing stance) to identify the top 3-5 critical risks, hidden assumptions, or alternative paths.
- `[ ]` **Sequential Challenge Loop**:
    - Do NOT output all findings in a single large list.
    - Select the **single most critical** risk or assumption first (e.g., any high-level "Intent" alternative).
    - Formulate a precise, challenging critique explaining the vulnerability or trade-off.
    - Propose a concrete alternative, mitigation strategy, or refactored code snippet.
    - Ask a sharp, open-ended question forcing the user to defend their choice or refine their design.
    - Stop executing tools/commands and wait for the user's response in chat.
    - Once the user responds, synthesize their feedback:
        - If they accept the mitigation, help them implement it immediately.
        - If they defend their original choice, refine the glossary/plan if necessary to record the constraint, then move to the next risk in your checklist.
- `[ ]` **Wrap Up**: Once all key risks have been resolved or addressed, present a brief final synthesis showing what improved and any resulting trade-offs.

---

## Context-Aware Checklists

### 1. Code Checklist 💻
When reviewing code, look for:
- **Edge-Case Behavior**: Off-by-one errors, empty inputs, null pointers, and missing error boundary captures.
- **Race Conditions & Concurrency**: Unlocked shared state, unawaited promises, non-atomic database transactions, and race conditions in concurrent loops.
- **Error Safety**: Swallowed errors (`catch {}` without logging/rethrowing), unhandled rejections, and failure to clean up resources (connections, file descriptors) in `finally` blocks.
- **Security & Authorization**: Missing input validation, lack of sanitation leading to injection (SQL, Command, XSS), and bypassable authorization checks.
- **Performance Bottlenecks**: `O(N^2)` loops, N+1 queries, unindexed queries, and blocking operations on main thread.
- **Seam & Boundary Failures (Trace)**: Unexpected side effects, incorrect state mutations, or failures at integration boundaries when tracing the call path (entry point → exit point) beyond the local diff or file.

### 2. Configuration Checklist ⚙️
When reviewing configuration files, look for:
- **Secret & Credential Exposure**: Hardcoded passwords, API keys, tokens, or private keys (recommend using environment variables/vaults).
- **Version Locking Mismatches**: Floating dependencies (using `*` or `latest`), which leads to non-deterministic builds.
- **Environment Drift**: Hardcoded values tied to local environments (e.g. `localhost:3000` in production configurations).
- **Permissive Security Defaults**: Exposing unnecessary ports, running containers as root, or using overly broad wildcard CORS policies.
- **Dependency Redundancy**: Outdated or unused packages/modules bloating the dependency tree.

### 3. Design & Plan Checklist 📝
When reviewing specifications (PRDs, Implementation Plans), look for:
- **Optimistic Bias / Happy Path Focus**: Assuming third-party APIs are 100% reliable, networks are instantaneous, and databases are infinite.
- **Scope Creep & Over-Engineering**: Features that are not essential to the core problem but add high maintenance overhead.
- **Architectural Lock-In**: Design decisions that would take months of refactoring to reverse (e.g., choosing a specific vendor-locked API or highly rigid database schema).
- **Neglected User Journeys**: Missing edge-case user flows (e.g., password reset, payment failure, offline synchronization, account deletion).
- **Non-Functional Blindspots**: Failure to specify latency budgets, backup strategies, rate limiting, and GDPR/data privacy compliance.
- **Domain Flow & State Tracing (Trace)**: Breakdowns in the end-to-end flow of domain events, data mutations, and boundaries when tracing the proposed flow against existing code and domain boundaries.
