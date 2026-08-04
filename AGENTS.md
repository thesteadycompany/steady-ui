# SteadyUI Agent Instructions

## Before Starting

1. Read `docs/superpowers/specs/2026-08-03-steady-ui-roadmap-design.md`, `ROADMAP.md`, and the current item.
2. Select only the highest-priority `ready` item whose dependencies are all `done`.
3. Keep at most one roadmap item `in_progress`.
4. If scope, public API, abstraction, or acceptance is ambiguous, mark the item `blocked` and record the exact question instead of guessing.

## Implementation Order

1. Write the smallest failing test that expresses the acceptance criterion.
2. Run it and preserve the expected failure.
3. Implement the minimum change that passes.
4. Refactor without changing behavior.
5. Update public documentation, the independent MobileExample demo, and a required use case in the same change.
6. Run the item's verification commands.

## UI Abstraction

1. Prefer a native SwiftUI Style protocol.
2. Use `ViewModifier` for reusable decoration or cross-cutting behavior.
3. Add a top-level custom `View` only for unique content structure, layout coordination, or state coordination, and record the rationale.
4. Keep `SteadyToggle` as the approved top-level custom View. Do not convert it to `ToggleStyle` or replace it with native `Toggle`.
5. Keep renderable public components and concrete Styles at module top level and prefix library-owned UI types with `Steady`.

## Completion

1. Confirm every applicable public UI completion criterion in the roadmap design.
2. Store the exact verification command, result summary, affected files, and review or CI link in `evidence`.
3. Change an item to `done` only after all acceptance checks pass and evidence is present.
4. Recompute `current_phase` and `current_focus`; mark the next dependency-satisfied item `ready`.
5. Do not lower test, accessibility, documentation, or evidence gates to recover schedule.

