# 0009. Metronome Stops Once per PR for High-Risk Work

**Status:** accepted

We decided that high-risk **Metronome** work stops once per PR, after a **Red Set**, instead of after every Red as ADR-0008 set out. A Red Set is every failing test of one PR, written together with only the stubs they need to compile, run to confirm each fails for its expected reason, and shown to the developer at one stop. The Green-Commit-Refactor cycles of that PR then run without further stops, unless a stop trigger fires.

### Context and Trade-offs

- **A stop after every Red was too slow.** The first high-risk task run with Metronome (a migration, an outward-facing call to a customer's LINE channel, and permissions) had 23 tests in a stack of 4 PRs. That meant 23 stops on top of the Kickoff. The developer asked to write all the Reds first and then go.
- **Writing every Red of the task at once does not work either.**
  - **Compile errors instead of Reds.** Later PRs' tests refer to types and methods that earlier PRs introduce. Written up front, they turn the whole package into compile errors, so nothing is red for the right reason and existing tests stop running.
  - **Tests pinned to an unsettled design.** Later tests depend on what earlier PRs settle, such as the shape of an adapter that a fake later imitates. Writing them first locks in guesses that then have to be rewritten.
- **One Red Set per PR keeps what mattered.**
  - **Fewer stops.** The developer still reviews every test before any code makes it pass, but in one batch per PR, about one stop per PR.
  - **Reds stay meaningful.** Stubs (types, signatures, a sentinel error, a method that returns "not implemented") let each test compile and fail on the missing behaviour, so a compile error is still not accepted as a Red.
  - **History is unchanged.** Commits are still one per cycle, so the developer can read the history commit by commit as before.
- **Low-risk work is unchanged.** It still writes one Red at a time and stops only at the Kickoff and on triggers.
- **Stop triggers still apply** during the cycles of a Red Set, as in ADR-0008.
