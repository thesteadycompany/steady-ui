# SteadyUI Component Contracts

Every public UI API must satisfy these contracts before its roadmap item can be
marked `done`. The rules apply to the default theme and to custom themes.

## State

- Interactive components define enabled, pressed, focused, and disabled output.
- Selection controls additionally define selected and unselected output.
- Components that perform asynchronous work document loading behavior; input
  and feedback components document error behavior when those states apply.
- State is never communicated by color alone. A shape, label, icon, value, or
  accessibility value must provide the same information.

## Size and touch target

- Shared control sizes are `small`, `medium`, and `large`.
- Visual padding and typography may change by size, but every interactive
  control keeps a hit region of at least 44 by 44 points.
- Width is independent from importance. Button width is either fitted to its
  label or expanded to the proposed container width.
- Components support multiline labels and accessibility Dynamic Type without
  clipping or overlapping adjacent content.

## Motion

- Press feedback may use color, opacity, or a scale no smaller than `0.98`.
- Motion uses a single short interactive spring and never delays the action.
- When Reduce Motion is enabled, scale and position animation are removed while
  nonmoving pressed feedback remains visible.

## Accessibility

- Native `Button`, `NavigationLink`, `Toggle`, `TextField`, and `ProgressView`
  semantics are preserved instead of recreated with tap gestures.
- VoiceOver labels describe the action or value, not the component's visual
  appearance. Disabled state and selection value remain discoverable.
- Foreground content meets the applicable contrast target in every enabled
  state. Focus is visible for keyboard and assistive input.
- Layout mirrors correctly in right-to-left locales. Leading and trailing slots
  are semantic rather than fixed left and right positions.

## Abstraction selection

Choose the first abstraction that can express the requirement:

1. A native SwiftUI Style when appearance changes but native semantics remain.
2. A `ViewModifier` for reusable decoration or cross-cutting presentation.
3. A top-level custom `View` for unique content structure, layout coordination,
   or state coordination. Record the reason in the roadmap item.

Renderable public components, concrete Styles, and component-specific public
types live at module top level and use the `Steady` prefix.

## Actions and interactive surfaces

- Action-button appearance is `filled`, `outlined`, or `plain`. Appearance
  communicates emphasis; `SteadyButtonTone` communicates accent or neutral
  color; native `ButtonRole` communicates destructive or cancel meaning.
- Button size and width are independent axes. Do not create a context-named
  action style such as CTA, form, list, or toolbar button.
- `SteadyListRow` owns leading, content, supporting, and trailing layout only.
  `Button`, `NavigationLink`, or `Toggle` owns the interaction semantics.
- A static card is arbitrary content decorated by `.steadyCard()`. A card with
  one obvious action can use a card `ButtonStyle` on `Button` or
  `NavigationLink`.
- A whole-row or whole-card target cannot contain another button, link, toggle,
  menu, or gesture target. A card with multiple actions must remain a static
  card and contain separately focusable controls.

## Examples and verification

- Every public component, Style, and modifier has an independent Components
  demo and appears in at least one realistic Use Cases screen.
- Demos include enabled, pressed-capable, disabled, role, size, and width
  variants that apply to the API.
- Verification covers the minimum iOS runtime, VoiceOver semantics, Dynamic
  Type, Reduce Motion, light and dark appearances, and right-to-left layout.
