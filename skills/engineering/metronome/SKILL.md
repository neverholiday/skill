---
name: metronome
description: Checkpointed red-green-refactor execution that keeps the developer able to follow every change. Agree a Kickoff first (scope, design drift, models, ordered test list, PR shape, risk), then run one test at a time through red, green and refactor with one commit per cycle, stopping only at agreed checkpoints, and close with a triaged code review before the PR. Use when the user wants to implement a task, feature or bug fix with TDD, wants small reviewable PRs with tests, or says they cannot keep up with the code being written.
---

# Metronome

Code is written in a steady beat the developer can follow: one test, red, green, refactor, commit, next. The developer's attention goes to the **Kickoff**, where the tests are agreed. After that, the tests are the contract, and the developer reads the commit history at their own pace instead of watching every line.

## Principles

- **Tests are the contract.** No production code is written before a failing test asks for it.
- **Attention where it pays.** The Kickoff is the one mandatory stop. Mid-cycle stops happen only on the triggers below, or once per PR, after its Red Set, when the risk is high.
- **Small PRs.** One concern per PR, and at most about 200 lines of non-test code. If the Kickoff estimate is bigger, propose a stack of PRs that each merge on their own.
- **Cheap checkpoints.** Every stop is at most 5 lines and ends with one question, so "ok" is a full answer.
- **One decision at a time.** Never ask a batch of questions.
- **Stay in the beat.** Never jump ahead to code that no current test needs.

## Workflow

### 1. Kickoff (stop and wait for OK)

Read the task, its DoD and the design references (glossary, ADRs, decisions) and the code the change touches. Then send:

```
## Kickoff: <task id and title>
**Scope:** in: ... | out: ... (refs: DoD items, decisions, ADRs)
**Design drift:** none | <what the code cannot do as designed, and a proposal>
**Models and signatures:** <types, structs, interfaces, function signatures; shapes only, no logic>
**Tests, in order:**
1. <TestName>: given ..., when ..., then ...
2. ...
**PR shape:** <files>, ~<n> lines of non-test code, 1 PR | split into <list>
**Risk:** low (stop at Kickoff only) | high (also stop once per PR, after its Red Set), because <reason>
**Question:** <one question, or "OK to start?">
```

- Mark the risk **high** for auth and permissions, deleting or migrating data, money, concurrency, or anything hard to reverse. Everything else is **low**. The developer can override it.
- Add, drop or reorder tests only here. A test list change after the Kickoff is a stop trigger.
- Do not touch any file until the developer says OK.

### 2. Red Set, once per PR (high risk only)

Before the first cycle of each PR in the stack:

1. Write every test of that PR. Add only the stubs they need to compile: types, signatures, a sentinel error, a method that returns "not implemented".
2. Run them. Each must fail for its expected reason, the missing behaviour; a compile error is not a Red. Every existing test must still pass.
3. Stop once and send one table, `# | Test | fails with | expected because`, then the Green plan in a few bullets. Wait for OK.
4. Run the cycles below for that PR's tests without further stops, unless a stop trigger fires.

Never write the Reds of a later PR ahead of time: its tests depend on what the earlier PRs settle.

### 3. Cycle, once per test

1. **Red.** Write the one test (high risk: it is already written in the Red Set). Run it and confirm it fails for the expected reason: the missing behaviour, not a compile error elsewhere or a broken fixture.
2. **Green.** Write the least code that makes this test pass. Run the test, then the package's tests.
3. **Commit** the test and the code together: `<type>(<scope>): <behaviour the test pins>`.
4. **Refactor.** Clean up only what this cycle touched. Tests must stay green. Commit separately as `refactor(<scope>): ...`, or skip and say so.
5. Report one line, `Green <n>/<total> <TestName>: +<a>/-<b> in <files>, <sha>`, and go to the next test.

### 4. Stop triggers (any risk level)

Stop, explain the root cause, propose one way forward, and wait when:

- A Red fails for an unexpected reason, or the test passes before any code is written.
- The code cannot follow the design, or the change would contradict a decision or ADR.
- An agreed test needs to change, or a new test is needed.
- The PR is heading past the agreed shape or the line budget.
- The next step is destructive, outward-facing or hard to reverse.

Do not work around a trigger silently. A fix applied without the developer's approval is the "giant leap" this skill exists to prevent.

### 5. Close

- [ ] Run the formatters, linters and the full relevant test suite. Report failures that already exist on the base branch separately, with proof.
- [ ] Do the end-to-end verification the project requires. If **sentinel** applies, follow its live-verification loop.
- [ ] **Code review.** Review the full diff against the base branch before any PR exists. Use the platform's code-review skill when there is one (in Claude Code, `code-review` on the branch diff). Otherwise, have a reviewer that hasn't seen your reasoning read the diff, such as a fresh subagent given only the diff and the task.
  1. Check every finding against the code, the design and the agreed scope. Mark each one **real**, **intended** (cite the decision, ADR or DoD), **out of scope** (name the follow-up task) or **pre-existing** (show that it also happens on the base branch).
  2. Send one short table with one row per finding and that verdict, then ask one question: which real findings to fix in this PR.
  3. Fix each agreed real defect as a new Red-Green-Refactor Cycle: first a test that reproduces it, then the fix. Cleanups that change no behaviour go in a `refactor` commit.
  4. Put the intended and out-of-scope findings into the PR description's Follow-up section, so the human reviewer sees they were weighed.
- [ ] Send the commit list (one line per cycle) so the developer can review it commit by commit.
- [ ] Draft the PR description:

```
## Summary
<what changed and why, one bullet per concern>

## Verification
<tests added; E2E steps and results; pre-existing failures>

## Release notes / runbook
<only if deploy steps or user-visible changes exist>

## Follow-up
<work deliberately left out of this PR, and where it goes>
```

## Working with other skills

- **sentinel** checks the change against the design and runs live verification. **metronome** sets the order in which code is written and when to stop. When both apply, run sentinel's pre-flight check before the Kickoff, use metronome's cycles to implement, and use sentinel's live-verification loop in Close.
- **grill-with-doc** or **devils-advocate** fit before the Kickoff, when the design itself is still open.

## Limits

- Code that only runs against real infrastructure (a seeder against a database, a migration, a deploy script) can't be red-green-refactored on its own. Pull its pure logic out and test that, for example catalog invariants, and cover the rest in Close with end-to-end verification.
