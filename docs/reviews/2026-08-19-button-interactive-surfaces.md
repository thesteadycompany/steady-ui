# Button and Interactive Surfaces Review

**Date:** 2026-08-19

**Branch:** `feature/button`

**Result:** Passed with no unresolved findings

## API and architecture

- Filled, Outlined, and Plain are concrete top-level `ButtonStyle` types.
- Tone, size, width, and native `ButtonRole` are independent axes.
- `SteadyListRow` owns only leading, primary, supporting, and trailing layout.
- Static Card decoration and single-target Card interaction share the same
  internal surface renderer while retaining separate public APIs.
- No compatibility aliases or executable references to CTA, Text, Underline,
  `SteadyButtonVariant`, or their old factories remain.

## Accessibility and visual review

- Accessibility inspection exposed action and navigation rows as buttons and
  the selection row as a switch with its current value.
- Static Card actions remained separate 44-point buttons. A single-target Card
  was exposed as one button with combined label content.
- Action buttons measured at least 44 points high for small, medium, and large
  sizes, and disabled state remained discoverable.
- Light, dark, right-to-left, and accessibility-extra-extra-extra-large layouts
  were inspected on iPhone 16 Pro with iOS 18.5. Content expanded without
  overlapping; leading and trailing slots mirrored in RTL.
- Press-scale motion reads `accessibilityReduceMotion`; reduced motion retains
  stationary color feedback and removes scale animation.

## Verification

- `./Scripts/verify ios --profile minimum --output json` — passed; 7 of 7
  SteadyUITests passed without warnings.
- `xcodebuildmcp simulator build --project-path Examples/MobileExample/MobileExample.xcodeproj --scheme MobileExample --simulator-id BB71DA41-A3DA-491A-940D-37D5B31C9C0E --output json` — passed.
- `xcodebuildmcp ui-automation snapshot-ui` — verified native roles, values,
  and touch frames for the Action Buttons and Interactive Surfaces demos.
- `git diff --check` — passed.
