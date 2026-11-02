# 0008. Metronome Checkpointed Red-Green-Refactor Execution

**Status:** accepted

We decided to add a skill named **Metronome** that implements code through a Red-Green-Refactor Cycle with fixed developer checkpoints, starting from an agreed Kickoff.

### Context and Trade-offs

- **The developer could not keep up.** When the agent wrote a whole change and reported afterwards, the developer had to reverse-engineer the models, tests and code from one large diff. Stopping at every step instead made the developer feel like the bottleneck. In practice, the developer added the most value at the design level (scope, design conflicts, data safety), not by reading code line by line.
- **The Kickoff is the one mandatory stop.** Scope, design drift, models and signatures, the ordered test list, PR shape and risk level are agreed before any file changes. After that, the tests are the contract, so the developer can review the per-cycle commit history at their own pace.
- **Risk decides how often to stop.** Low-risk work stops only at the Kickoff and on triggers: an unexpected red, design drift, a test list change, or a PR outgrowing its shape. High-risk work (auth, data deletion or migration, money, concurrency, anything hard to reverse) also stops after every Red. The developer can override the level.
- **Small PRs with tests.** One concern per PR and at most about 200 lines of non-test code. Bigger work is split into a stack of independently mergeable PRs. A real case motivated the rule: a small seeder PR without tests missed a catalog invariant (one scope set per module) that a reviewer caught later.
- **Ends with a code review before the PR.** A reviewer who doesn't share the agent's reasoning reads the whole diff. Every finding is checked against the code, design and scope, then labelled real, intended, out of scope or pre-existing. Real defects are fixed test-first, as new cycles. This moves what an automated PR reviewer would catch to before the PR. It also keeps out of the PR the findings that are intended by design, which would otherwise cost the developer a review round.
- **Cheap checkpoints.** Every stop is at most 5 lines and ends with one question, which keeps a stop's cost close to the time it takes to answer "ok".
- **Relationship to Sentinel (ADR-0006, ADR-0007).** Metronome does not replace Sentinel. Sentinel checks the change against the design and runs the live-verification loop. Metronome governs the order code is written in and when to stop. Metronome's stop triggers follow ADR-0007's RCA-first rule: explain the cause, propose a fix, and wait for approval.
