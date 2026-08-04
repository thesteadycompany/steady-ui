# SteadyUI v1 Public API Baseline Design

**Status:** Approved for implementation planning

**Date:** 2026-08-04

**Roadmap item:** SU-002

## Goal

Normalize the existing badge and button APIs into the approved v1 naming baseline before adding new components. Migrate the library, tests, documentation, component demos, and a minimal Settings Form use case together without compatibility wrappers.

## Scope

This item changes names and call-site labels while preserving current rendering and interaction behavior. It also adds a minimal Settings Form screen that demonstrates the migrated API in a realistic composition.

The following work remains outside SU-002:

- Reorganizing the MobileExample root into complete `Components` and `Use Cases` navigation. SU-003 owns that structure.
- Adding new button states, sizes, motion behavior, or Checkbox. SU-004 owns those contracts.
- Redesigning Badge or Button visuals.
- Adding persistence, networking, validation, or application services to the Settings Form.

## Public API Transition

Apply the transition atomically and do not add deprecated aliases, type aliases, or compatibility factories.

| Existing API | v1 API |
| --- | --- |
| `SteadyBadgeStyle` | `SteadyBadgeEmphasis` |
| `SteadyBadgeType` | `SteadyBadgeRole` |
| `SteadyBadge(_:type:style:size:)` | `SteadyBadge(_:role:emphasis:size:)` |
| `SteadyCTAButonStyle` | `SteadyCTAButtonStyle` |
| `SteadyButtonType` | `SteadyButtonVariant` |
| `SteadyCTAButtonStyle(type:)` | `SteadyCTAButtonStyle(variant:)` |
| `.buttonStyle(.cta)` | `.buttonStyle(.steadyCTA)` |
| `.buttonStyle(.cta(variant))` | `.buttonStyle(.steadyCTA(variant))` |
| `.buttonStyle(.text)` | `.buttonStyle(.steadyText)` |
| `.buttonStyle(.text(variant, size:))` | `.buttonStyle(.steadyText(variant, size:))` |
| `.buttonStyle(.underline)` | `.buttonStyle(.steadyUnderline)` |
| `.buttonStyle(.underline(variant, size:))` | `.buttonStyle(.steadyUnderline(variant, size:))` |

`SteadyBadgeRole` retains `info`, `success`, `warning`, `critical`, and `neutral`. `SteadyBadgeEmphasis` retains `primary` and `secondary`. `SteadyButtonVariant` retains `primary`, `secondary`, and `destructive`. Defaults and visual output remain unchanged.

## Source Structure

Rename the declaration files to match their public types. Update stored properties and initializer labels to use the new domain terms:

- Badge uses `role` to choose semantic status colors and `emphasis` to choose filled or outlined presentation.
- Button styles use `variant` to choose primary, secondary, or destructive action colors.
- Static `ButtonStyle` factories keep native SwiftUI `Button` semantics and use the required `steady` prefix.

No new rendering abstraction is introduced. Existing `View` and `ButtonStyle` boundaries remain intact.

## MobileExample

Update every existing Badge and Button demo call site to the v1 API.

Add `SettingsFormUseCase` as a small, independently navigable screen. It uses local `@State` only and combines:

- `SteadyBadge` to communicate account or notification status.
- `SteadyToggle` for an editable notification preference.
- A secondary text action using `.steadyText`.
- A primary save action using `.steadyCTA`.

Add a `Settings Form` navigation link to the existing root form. Do not perform the broader Components/Use Cases navigation reorganization reserved for SU-003.

## Documentation

Update README usage snippets to use the v1 Badge and Button names. Existing roadmap and design references may retain old names only where they describe migration history; executable examples must use the v1 names.

## Testing and Verification

Use separate red-green cycles for Badge and Button API contracts:

1. Add a compile-time public contract test that constructs `SteadyBadgeRole`, `SteadyBadgeEmphasis`, and `SteadyBadge` with `role:` and `emphasis:`. Confirm it fails because the new API does not exist.
2. Implement the minimal Badge rename and confirm the contract passes.
3. Add a compile-time public contract test for `SteadyButtonVariant`, `SteadyCTAButtonStyle`, and the three prefixed static factories. Confirm it fails because the new API does not exist.
4. Implement the minimal Button rename and confirm the contract passes.
5. Update documentation and MobileExample call sites, then build the full iOS package and example through the standard verification wrapper.

Because removed Swift symbols cannot be referenced by a passing compile test, verify absence with an exact source inventory search. Migration-history documentation is excluded from this absence check.

The completion gate is:

```sh
./Scripts/verify ios --profile minimum --output json
```

The item may move to `done` only when the command succeeds, the old declarations and factories are absent from executable source, MobileExample compiles with the Settings Form use case, and exact evidence is recorded in `ROADMAP.md`.

## Failure Behavior

This change adds no runtime failure paths. Incorrect or incomplete migrations fail at compile time. A failed full verification keeps SU-002 `in_progress`, and the failure summary is reported without weakening the acceptance gate.
