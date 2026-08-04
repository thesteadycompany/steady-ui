# SteadyUI Roadmap

```yaml
roadmap_version: 1
last_updated: 2026-08-04
horizon: 10-weeks
current_phase: foundation
current_focus: SU-002
owner: repository-maintainer
```

허용 상태는 `planned`, `ready`, `in_progress`, `blocked`, `done`, `deferred`다. 모든 `depends_on`이 `done`일 때만 `ready`가 될 수 있고, 검증 결과가 `evidence`에 기록된 경우에만 `done`이 될 수 있다.

## Work Items

### SU-001 — Establish the verification foundation

```yaml
id: SU-001
title: Establish the verification foundation
status: done
priority: P0
phase: foundation
depends_on: []
goal: Make roadmap execution and iOS verification reproducible on a clean checkout.
preferred_abstraction: build-tooling
abstraction_rationale: This item coordinates verification and does not render UI.
mobile_example_use_cases: []
acceptance:
  - ROADMAP.md and AGENTS.md identify the next valid work item.
  - Package and MobileExample target iOS 18.0.
  - SteadyUITests verifies the first public token contracts.
  - Local and CI use Scripts/verify for iOS testing.
  - Both profiles select a simulator by runtime-specific UDID.
verification:
  - ./Scripts/verify environment --profile minimum --output json
  - ./Scripts/verify ios --profile minimum --output json
  - ./Scripts/verify environment --profile ci --output json
  - ./Scripts/verify ios --profile ci --output json
evidence:
  - "2026-08-04: ./Scripts/verify ios --profile minimum --output json passed in a clean git archive on iPhone 16 Pro with iOS 18.5."
  - "Tests: ThemeEnvironmentTests 2 passed; PublicContractTests 2 passed."
  - "CI: https://github.com/thesteadycompany/steady-ui/actions/runs/30866870333"
  - "Files: ROADMAP.md, AGENTS.md, README.md, Package.swift, MobileExample project, Tests/SteadyUITests, Scripts/verify, and .github/workflows/verify.yml."
```

### SU-002 — Normalize the v1 public API baseline

```yaml
id: SU-002
title: Normalize the v1 public API baseline
status: in_progress
priority: P0
phase: foundation
depends_on: [SU-001]
goal: Establish the source-compatible v1 naming baseline before adding components.
preferred_abstraction: api-design
abstraction_rationale: No release tag exists, so Sources and MobileExample can migrate together without compatibility wrappers.
mobile_example_use_cases:
  - Settings Form
acceptance:
  - The approved v1 API transition table is applied without deprecated wrappers.
  - SteadyBadgeStyle, SteadyBadgeType, SteadyCTAButonStyle, and SteadyButtonType are absent.
  - Sources and MobileExample compile with the replacement names.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-003 — Define tokens and component contracts

```yaml
id: SU-003
title: Define tokens and component contracts
status: planned
priority: P0
phase: foundation
depends_on: [SU-002]
goal: Define the design, state, accessibility, and example contract every public UI API must follow.
preferred_abstraction: design-contracts
abstraction_rationale: This item defines cross-component rules and does not render UI.
mobile_example_use_cases:
  - Settings Form
acceptance:
  - State, size, touch target, motion, and accessibility rules are documented.
  - Style, ViewModifier, and custom View selection templates exist.
  - MobileExample separates Components and Use Cases.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-004 — Stabilize actions and add checkbox

```yaml
id: SU-004
title: Stabilize actions and add checkbox
status: planned
priority: P0
phase: actions
depends_on: [SU-003]
goal: Make action styles complete and add accessible binary selection.
preferred_abstraction: ButtonStyle, ToggleStyle
abstraction_rationale: Native styles preserve Button and Toggle action, binding, role, and accessibility semantics.
mobile_example_use_cases:
  - Settings Form
acceptance:
  - CTA, Text, and Underline styles cover required sizes and states.
  - Checkbox is implemented as ToggleStyle.
  - Independent demos, Settings Form usage, and accessibility checks pass.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-005 — Complete inputs and selection

```yaml
id: SU-005
title: Complete inputs and selection
status: planned
priority: P0
phase: inputs
depends_on: [SU-004]
goal: Complete the minimum accessible form controls.
preferred_abstraction: TextFieldStyle, ToggleStyle, top-level composition View
abstraction_rationale: Native styles preserve input and selection semantics; SteadyToggle remains the approved custom View for direct track, thumb, and motion control.
mobile_example_use_cases:
  - Authentication Form
  - Settings Form
acceptance:
  - Box and Line styles work with TextField and SecureField.
  - Radio uses ToggleStyle and its group is a top-level composition View.
  - SteadyToggle remains a custom View and passes disabled, VoiceOver, Dynamic Type, and Reduce Motion checks.
  - Switch Tab accessibility and motion checks pass.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-006 — Add content foundations

```yaml
id: SU-006
title: Add content foundations
status: planned
priority: P1
phase: content
depends_on: [SU-005]
goal: Provide low-level content primitives for common screens.
preferred_abstraction: ViewModifier, top-level custom View
abstraction_rationale: Divider and Card decorate arbitrary content, while Avatar and Badge own unique content structure.
mobile_example_use_cases:
  - Content Card or Dashboard
acceptance:
  - Icon usage rules preserve native Image.
  - Divider and Card are modifiers.
  - Avatar is a top-level View and Badge satisfies the public UI completion definition.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-007 — Add chip and composition quality

```yaml
id: SU-007
title: Add chip and composition quality
status: planned
priority: P1
phase: selection
depends_on: [SU-006]
goal: Provide stateful chip selection and validate composition under constrained layouts.
preferred_abstraction: ToggleStyle, ButtonStyle
abstraction_rationale: Persistent selection uses Toggle semantics and one-shot actions use Button semantics.
mobile_example_use_cases:
  - Content Card or Dashboard
acceptance:
  - Chip semantics select ToggleStyle or ButtonStyle according to interaction.
  - Switch Tab defines overflow and long-text behavior.
  - RTL, large Dynamic Type, and API consistency checks pass.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-008 — Add feedback components

```yaml
id: SU-008
title: Add feedback components
status: planned
priority: P1
phase: feedback
depends_on: [SU-007]
goal: Express loading, warning, error, and empty states consistently.
preferred_abstraction: ProgressViewStyle, ViewModifier, top-level custom View
abstraction_rationale: Native ProgressView keeps progress semantics, Skeleton decorates content, and Banner and Empty State own content structure.
mobile_example_use_cases:
  - Loading/Error/Empty Feedback Flow
acceptance:
  - Determinate and indeterminate progress use ProgressViewStyle.
  - Skeleton respects Reduce Motion.
  - Banner and Empty State convey meaning without color alone.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-009 — Validate internal adoption and freeze API

```yaml
id: SU-009
title: Validate internal adoption and freeze API
status: planned
priority: P0
phase: integration
depends_on: [SU-008]
goal: Validate release-candidate APIs in real internal screens and produce the API freeze candidate.
preferred_abstraction: product-integration
abstraction_rationale: This item evaluates consumers and does not introduce a new rendering abstraction.
mobile_example_use_cases:
  - Settings Form
  - Authentication Form
  - Content Card or Dashboard
  - Loading/Error/Empty Feedback Flow
acceptance:
  - At least two internal representative screens use the release candidate.
  - App-specific workarounds and missing states are audited.
  - Performance and compile-time baselines and the API freeze candidate are recorded.
verification:
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```

### SU-010 — Complete release documentation and v1.0 gates

```yaml
id: SU-010
title: Complete release documentation and v1.0 gates
status: planned
priority: P0
phase: release
depends_on: [SU-009]
goal: Make adoption and release reproducible for an external consumer.
preferred_abstraction: documentation, release-tooling
abstraction_rationale: This item packages verified APIs and does not introduce a new rendering abstraction.
mobile_example_use_cases:
  - Settings Form
  - Authentication Form
  - Content Card or Dashboard
  - Loading/Error/Empty Feedback Flow
acceptance:
  - README, DocC, CONTRIBUTING, CHANGELOG, support policy, and approved LICENSE are complete.
  - Release candidate and v1.0 checklists have no incomplete items.
  - A fresh consumer sample installs and uses the package.
verification:
  - ./Scripts/verify environment --profile minimum --output json
  - ./Scripts/verify ios --profile minimum --output json
evidence: []
```
