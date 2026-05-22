---
name: to-prd
description: Turn the current conversation context into a PRD and publish it to the local project task index. Use when user wants to create a PRD from the current context.
---

# Product Requirement Document (PRD) Skill

This skill takes the current conversation context and codebase understanding and produces a PRD. Do NOT interview the user — just synthesize what you already know.

## Process

1. Explore the repo to understand the current state of the codebase, if you haven't already. Use the project's domain glossary vocabulary (`CONTEXT.md`) throughout the PRD, and respect any ADRs in the area you're touching.

2. Sketch out the major modules you will need to build or modify to complete the implementation. Actively look for opportunities to extract deep modules that can be tested in isolation.

   A deep module (as opposed to a shallow module) is one which encapsulates a lot of functionality in a simple, testable interface which rarely changes.

   Check with the user that these modules match their expectations. Check with the user which modules they want tests written for.

3. Write the PRD using the template below to `docs/prd.md`.

4. Map publishing: Since this project runs on a local-first workflow, **"publishing to the project task index"** means invoking the `/to-tasks` skill right after the PRD is generated to automatically break it down into local markdown tasks under `docs/tasks/` and compile the dashboard index in `docs/tasks/README.md`. Ensure each user story has a clear unique ID (e.g. `US-1`, `US-2`) to support full traceability.

---

<prd-template>

## Problem Statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A LONG, numbered list of user stories. Prefix each story with a unique story ID (**`[US-X]`**). Each user story should be in the format of:

1. **[US-1]** As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. **[US-1]** As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

This list of user stories should be extremely extensive and cover all aspects of the feature.

## Implementation Decisions

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- **System Architecture & Sequence Diagrams (Optional but Recommended):** Use Mermaid.js flowcharts or sequence diagrams to visualize the components, request flows, or state machines.
- **Monitoring & Observability Decisions (Optional but Recommended):** Define structured logging standards (JSON fields, logging levels), APM integrations (Sentry, OpenTelemetry, Datadog), and alerting thresholds when building production-facing features.
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They may end up being outdated very quickly.

Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it within the relevant decision and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

## Out of Scope

A description of the things that are out of scope for this PRD.

## Further Notes

Any further notes about the feature.

</prd-template>
