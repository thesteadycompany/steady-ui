# SteadyUI v1 Public API Baseline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the existing Badge and Button names with the approved v1 API, migrate every consumer, and add a compiling Settings Form use case without compatibility wrappers.

**Architecture:** Preserve the existing top-level `SteadyBadge` view and native SwiftUI `ButtonStyle` implementations while renaming their semantic inputs and static factories atomically. Compile-time Swift Testing contracts define the new public surface before source changes, and MobileExample remains an independent consumer that verifies the migration and realistic composition.

**Tech Stack:** Swift 6.3.1, SwiftUI, Swift Testing, Swift Package Manager, iOS 18.0+, Xcode 26.4.1, XcodeBuildMCP 2.1.0

## Global Constraints

- Work only on roadmap item `SU-002`; keep it as the sole `in_progress` item until every gate passes.
- The Package and MobileExample deployment minimum remains iOS 18.0.
- Preserve all current rendering, defaults, enum cases, and interaction behavior.
- Do not add deprecated aliases, type aliases, compatibility wrappers, or old static factories.
- Keep renderable library UI and concrete Styles as top-level public types with the `Steady` prefix.
- Keep Button APIs as native SwiftUI `ButtonStyle`; do not introduce a new top-level Button view.
- Keep `SteadyToggle` as the approved top-level custom View.
- Do not reorganize the full `Components` and `Use Cases` navigation; SU-003 owns that work.
- The Settings Form uses local `@State` only and adds no persistence, networking, validation, or application services.
- Update tests, README, independent component demos, and the Settings Form use case in the same change.
- Use `./Scripts/verify ios --profile minimum --output json` as the final iOS gate.

---

### Task 1: Establish and implement the Badge v1 contract

**Files:**
- Test: `Tests/SteadyUITests/PublicContractTests.swift`
- Move: `Sources/SteadyUI/Components/Badges/SteadyBadgeType.swift` → `Sources/SteadyUI/Components/Badges/SteadyBadgeRole.swift`
- Move: `Sources/SteadyUI/Components/Badges/SteadyBadgeStyle.swift` → `Sources/SteadyUI/Components/Badges/SteadyBadgeEmphasis.swift`
- Modify: `Sources/SteadyUI/Components/Badges/SteadyBadge.swift`

**Interfaces:**
- Consumes: Existing `SteadyBadge`, `SteadyBadgeSize`, and theme token behavior.
- Produces: `SteadyBadgeRole`, `SteadyBadgeEmphasis`, and `SteadyBadge.init(_:role:emphasis:size:)`.

- [ ] **Step 1: Add the failing Badge compile-time contract**

Append this test inside `PublicContractTests`:

```swift
  @Test("badge uses the v1 role and emphasis API")
  @MainActor
  func badgeUsesV1RoleAndEmphasisAPI() {
    let role: SteadyBadgeRole = .success
    let emphasis: SteadyBadgeEmphasis = .secondary

    requireEquatableAndSendable(SteadyBadgeRole.self)
    requireEquatableAndSendable(SteadyBadgeEmphasis.self)
    _ = SteadyBadge(
      "Synced",
      role: role,
      emphasis: emphasis,
      size: .small
    )
  }
```

- [ ] **Step 2: Run the iOS test gate and preserve the expected RED result**

Run:

```sh
./Scripts/verify ios --profile minimum --output json
```

Expected: nonzero exit with compiler diagnostics that `SteadyBadgeRole` and `SteadyBadgeEmphasis` are not in scope. Confirm the failure is caused by the missing v1 API, not the environment or a test typo.

- [ ] **Step 3: Rename the Badge enum files and declarations**

Run:

```sh
git mv Sources/SteadyUI/Components/Badges/SteadyBadgeType.swift Sources/SteadyUI/Components/Badges/SteadyBadgeRole.swift
git mv Sources/SteadyUI/Components/Badges/SteadyBadgeStyle.swift Sources/SteadyUI/Components/Badges/SteadyBadgeEmphasis.swift
```

Replace the moved files with these declarations:

```swift
import Foundation

public enum SteadyBadgeRole: Equatable, Sendable {
  case info
  case success
  case warning
  case critical
  case neutral
}
```

```swift
import Foundation

public enum SteadyBadgeEmphasis: Equatable, Sendable {
  case primary
  case secondary
}
```

- [ ] **Step 4: Migrate `SteadyBadge` to role and emphasis terminology**

Change its stored properties and initializer to:

```swift
  private let role: SteadyBadgeRole
  private let emphasis: SteadyBadgeEmphasis
  private let size: SteadyBadgeSize

  public init(
    _ title: String,
    role: SteadyBadgeRole = .info,
    emphasis: SteadyBadgeEmphasis = .primary,
    size: SteadyBadgeSize = .medium
  ) {
    self.title = title
    self.role = role
    self.emphasis = emphasis
    self.size = size
  }
```

Apply these exact internal identifier replacements without changing any case bodies:

```text
if style == .secondary → if emphasis == .secondary
switch type → switch role
switch style → switch emphasis
```

- [ ] **Step 5: Run the iOS test gate and confirm the Badge contract is GREEN**

Run:

```sh
./Scripts/verify ios --profile minimum --output json
```

Expected: exit 0 with the new Badge contract test passing. Existing MobileExample call sites are not part of this package test workspace and will be migrated in Task 3.

- [ ] **Step 6: Commit the Badge contract**

```sh
git add Tests/SteadyUITests/PublicContractTests.swift Sources/SteadyUI/Components/Badges
git commit -m "refactor: normalize badge API names"
```

---

### Task 2: Establish and implement the Button v1 contract

**Files:**
- Test: `Tests/SteadyUITests/PublicContractTests.swift`
- Move: `Sources/SteadyUI/Components/Buttons/SteadyButtonType.swift` → `Sources/SteadyUI/Components/Buttons/SteadyButtonVariant.swift`
- Move: `Sources/SteadyUI/Components/Buttons/CTA/SteadyCTAButonStyle.swift` → `Sources/SteadyUI/Components/Buttons/CTA/SteadyCTAButtonStyle.swift`
- Modify: `Sources/SteadyUI/Components/Buttons/CTA/ButtonStyle+CTA.swift`
- Modify: `Sources/SteadyUI/Components/Buttons/Text/SteadyTextButtonStyle.swift`
- Modify: `Sources/SteadyUI/Components/Buttons/Text/SteadyUnderlineTextButtonStyle.swift`
- Modify: `Sources/SteadyUI/Components/Buttons/Text/ButtonStyle+Text.swift`

**Interfaces:**
- Consumes: Existing CTA, text, and underline rendering behavior plus `SteadyTextButtonSize`.
- Produces: `SteadyButtonVariant`, `SteadyCTAButtonStyle`, direct `variant:` initializers, `.steadyCTA`, `.steadyText`, and `.steadyUnderline`.

- [ ] **Step 1: Add the failing Button compile-time contract**

Append this test inside `PublicContractTests`:

```swift
  @Test("button styles use the v1 variant and prefixed factories")
  @MainActor
  func buttonStylesUseV1VariantAndPrefixedFactories() {
    let variant: SteadyButtonVariant = .secondary
    let cta: SteadyCTAButtonStyle = .steadyCTA(variant)
    let text: SteadyTextButtonStyle = .steadyText(variant, size: .small)
    let underline: SteadyUnderlineTextButtonStyle = .steadyUnderline(
      variant,
      size: .large
    )

    requireEquatableAndSendable(SteadyButtonVariant.self)
    _ = SteadyCTAButtonStyle(variant: variant)
    _ = SteadyTextButtonStyle(variant: variant, size: .medium)
    _ = SteadyUnderlineTextButtonStyle(variant: variant, size: .medium)
    _ = cta
    _ = text
    _ = underline
  }
```

- [ ] **Step 2: Run the iOS test gate and preserve the expected RED result**

Run:

```sh
./Scripts/verify ios --profile minimum --output json
```

Expected: nonzero exit with compiler diagnostics that `SteadyButtonVariant`, `SteadyCTAButtonStyle`, and the prefixed factories are unavailable. Confirm this is a missing-API failure.

- [ ] **Step 3: Rename the Button variant and CTA style files**

Run:

```sh
git mv Sources/SteadyUI/Components/Buttons/SteadyButtonType.swift Sources/SteadyUI/Components/Buttons/SteadyButtonVariant.swift
git mv Sources/SteadyUI/Components/Buttons/CTA/SteadyCTAButonStyle.swift Sources/SteadyUI/Components/Buttons/CTA/SteadyCTAButtonStyle.swift
```

Define the variant enum as:

```swift
import Foundation

public enum SteadyButtonVariant: Equatable, Sendable {
  case primary
  case secondary
  case destructive
}
```

- [ ] **Step 4: Migrate all three concrete Button styles to `variant`**

In `SteadyCTAButtonStyle`, use:

```swift
public struct SteadyCTAButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.theme) private var theme
  private let variant: SteadyButtonVariant

  public init(variant: SteadyButtonVariant) {
    self.variant = variant
  }
```

Keep the existing body, colors, animation, and cases, changing only `switch type` to `switch variant`.

In both text styles, use this property and initializer shape while preserving each existing body:

```swift
  private let variant: SteadyButtonVariant
  private let size: SteadyTextButtonSize

  public init(
    variant: SteadyButtonVariant = .primary,
    size: SteadyTextButtonSize = .medium
  ) {
    self.variant = variant
    self.size = size
  }
```

Change their foreground-color switches from `type` to `variant` without altering branches.

- [ ] **Step 5: Replace the static factories with the v1-prefixed surface**

Replace `ButtonStyle+CTA.swift` with:

```swift
import SwiftUI

extension ButtonStyle where Self == SteadyCTAButtonStyle {
  public static var steadyCTA: Self {
    steadyCTA(.primary)
  }

  public static func steadyCTA(_ variant: SteadyButtonVariant) -> Self {
    SteadyCTAButtonStyle(variant: variant)
  }
}
```

Replace `ButtonStyle+Text.swift` with:

```swift
import SwiftUI

extension ButtonStyle where Self == SteadyTextButtonStyle {
  public static var steadyText: Self {
    steadyText(.primary)
  }

  public static func steadyText(
    _ variant: SteadyButtonVariant = .primary,
    size: SteadyTextButtonSize = .medium
  ) -> Self {
    SteadyTextButtonStyle(variant: variant, size: size)
  }
}

extension ButtonStyle where Self == SteadyUnderlineTextButtonStyle {
  public static var steadyUnderline: Self {
    steadyUnderline(.primary)
  }

  public static func steadyUnderline(
    _ variant: SteadyButtonVariant = .primary,
    size: SteadyTextButtonSize = .medium
  ) -> Self {
    SteadyUnderlineTextButtonStyle(variant: variant, size: size)
  }
}
```

- [ ] **Step 6: Run the iOS test gate and confirm the Button contract is GREEN**

Run:

```sh
./Scripts/verify ios --profile minimum --output json
```

Expected: exit 0 with both new v1 contract tests and all existing package tests passing.

- [ ] **Step 7: Commit the Button contract**

```sh
git add Tests/SteadyUITests/PublicContractTests.swift Sources/SteadyUI/Components/Buttons
git commit -m "refactor: normalize button API names"
```

---

### Task 3: Migrate existing MobileExample demos and README

**Files:**
- Modify: `Examples/MobileExample/MobileExample/Demo/BadgeDemo.swift`
- Modify: `Examples/MobileExample/MobileExample/Demo/Buttons/CTAButtonDemo.swift`
- Modify: `Examples/MobileExample/MobileExample/Demo/Buttons/TextButtonDemo.swift`
- Modify: `Examples/MobileExample/MobileExample/Demo/ScrollViews/BottomScrollViewDemo.swift`
- Modify: `README.md`

**Interfaces:**
- Consumes: The Badge and Button v1 APIs produced by Tasks 1 and 2.
- Produces: Existing demos and public README examples that compile exclusively against the v1 API.

- [ ] **Step 1: Build the independent example before migration and preserve the expected RED result**

Run:

```sh
xcodebuild -project Examples/MobileExample/MobileExample.xcodeproj -scheme MobileExample -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5' build
```

Expected: nonzero exit with unavailable old Badge labels/types or old ButtonStyle factories. Confirm the failure comes from the consumer migration, not simulator selection.

- [ ] **Step 2: Migrate every existing demo call site**

Apply these exact call-site transformations:

```text
SteadyBadge(..., type: X, style: Y) → SteadyBadge(..., role: X, emphasis: Y)
SteadyBadge(..., type: X) → SteadyBadge(..., role: X)
.buttonStyle(.cta) → .buttonStyle(.steadyCTA)
.buttonStyle(.cta(X)) → .buttonStyle(.steadyCTA(X))
.buttonStyle(.text) → .buttonStyle(.steadyText)
.buttonStyle(.text(X, size: Y)) → .buttonStyle(.steadyText(X, size: Y))
.buttonStyle(.underline) → .buttonStyle(.steadyUnderline)
.buttonStyle(.underline(X, size: Y)) → .buttonStyle(.steadyUnderline(X, size: Y))
```

Do not change layout, copy, action behavior, or style variants.

- [ ] **Step 3: Add README examples for the v1 calls**

Insert this section after “Apply the Default Theme”:

````markdown
## Use Components

```swift
import SteadyUI
import SwiftUI

struct AccountStatusView: View {
  var body: some View {
    VStack {
      SteadyBadge(
        "Active",
        role: .success,
        emphasis: .secondary
      )

      Button("Save") {}
        .buttonStyle(.steadyCTA)

      Button("Reset") {}
        .buttonStyle(.steadyText(.secondary))
    }
  }
}
```
````

- [ ] **Step 4: Rebuild MobileExample and confirm the migrated consumer is GREEN**

Run:

```sh
xcodebuild -project Examples/MobileExample/MobileExample.xcodeproj -scheme MobileExample -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5' build
```

Expected: exit 0 with `** BUILD SUCCEEDED **`.

- [ ] **Step 5: Commit the existing-consumer migration**

```sh
git add README.md Examples/MobileExample/MobileExample/Demo
git commit -m "docs: migrate examples to v1 API names"
```

---

### Task 4: Add the minimal Settings Form use case

**Files:**
- Create: `Examples/MobileExample/MobileExample/UseCases/SettingsFormUseCase.swift`
- Modify: `Examples/MobileExample/MobileExample/App.swift`

**Interfaces:**
- Consumes: `SteadyBadge.init(_:role:emphasis:size:)`, `.steadyText`, `.steadyCTA`, `SteadyToggle`, and `SteadyTheme` environment tokens.
- Produces: An independently navigable `SettingsFormUseCase` using only local `@State`.

- [ ] **Step 1: Create the Settings Form with the already-tested v1 API composition**

Create `SettingsFormUseCase.swift` with:

```swift
import SteadyUI
import SwiftUI

struct SettingsFormUseCase: View {
  @Environment(\.theme) private var theme
  @State private var notificationsEnabled = true
  @State private var isSaved = false

  var body: some View {
    Form {
      Section("Account") {
        HStack {
          VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            Text("Workspace")
              .font(theme.fonts.label.large)
            Text("Steady Team")
              .font(theme.fonts.body.medium)
              .foregroundStyle(theme.colors.text.secondary)
          }

          Spacer()

          SteadyBadge(
            isSaved ? "Saved" : "Active",
            role: isSaved ? .success : .info,
            emphasis: .secondary
          )
        }

        Button("Reset preferences", action: resetPreferencesButtonTapped)
          .buttonStyle(.steadyText(.secondary))
      }

      Section("Notifications") {
        HStack {
          Text("Product updates")
          Spacer()
          SteadyToggle(isOn: $notificationsEnabled)
            .accessibilityLabel("Product updates")
        }
      }

      Section {
        Button("Save changes", action: saveChangesButtonTapped)
          .buttonStyle(.steadyCTA)
      }
    }
    .navigationTitle("Settings Form")
    .onChange(of: notificationsEnabled) {
      isSaved = false
    }
  }

  private func resetPreferencesButtonTapped() {
    notificationsEnabled = false
    isSaved = false
  }

  private func saveChangesButtonTapped() {
    isSaved = true
  }
}
```

- [ ] **Step 2: Link the use case from the existing root without reorganizing navigation**

Add this section as the last section inside the current root `Form`:

```swift
        Section {
          NavigationLink("Settings Form") {
            SettingsFormUseCase()
          }
        } header: {
          Text("Use Cases")
        }
```

- [ ] **Step 3: Build MobileExample and verify the use case compiles**

Run:

```sh
xcodebuild -project Examples/MobileExample/MobileExample.xcodeproj -scheme MobileExample -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5' build
```

Expected: exit 0 with `** BUILD SUCCEEDED **`. The file-system-synchronized Xcode group includes the new Swift file without editing `project.pbxproj`.

- [ ] **Step 4: Commit the use case**

```sh
git add Examples/MobileExample/MobileExample/App.swift Examples/MobileExample/MobileExample/UseCases/SettingsFormUseCase.swift
git commit -m "feat: add settings form use case"
```

---

### Task 5: Audit the migration, review, verify, and complete SU-002

**Files:**
- Modify: `ROADMAP.md`
- Verify: All files changed in Tasks 1–4

**Interfaces:**
- Consumes: The complete v1 migration, MobileExample use case, standard verification wrapper, and roadmap state machine.
- Produces: Exact verification evidence, `SU-002: done`, `SU-003: ready`, and `current_focus: SU-003`.

- [ ] **Step 1: Prove old executable symbols and call sites are absent**

Run:

```sh
rg -n 'SteadyBadgeStyle|SteadyBadgeType|SteadyCTAButonStyle|SteadyButtonType|\.buttonStyle\(\.(cta|text|underline)(\(|\))' Sources Examples Tests README.md
```

Expected: exit 1 with no matches.

- [ ] **Step 2: Prove every replacement API is present in executable source or documentation**

Run:

```sh
rg -n 'SteadyBadgeEmphasis|SteadyBadgeRole|SteadyCTAButtonStyle|SteadyButtonVariant|steadyCTA|steadyText|steadyUnderline' Sources Examples Tests README.md
```

Expected: exit 0 with matches for all seven replacement names.

- [ ] **Step 3: Run whitespace and change-scope checks**

Run:

```sh
git diff --check
git status --short
git diff --stat HEAD~4
```

Expected: `git diff --check` exits 0; status contains only intended SU-002 files if any remain uncommitted; the four implementation commits contain no unrelated files.

- [ ] **Step 4: Run the required iOS package gate fresh**

Run:

```sh
./Scripts/verify ios --profile minimum --output json
```

Expected: exit 0, top-level JSON `status` equals `passed`, and all six tests pass: four `PublicContractTests` plus two `ThemeEnvironmentTests`.

- [ ] **Step 5: Run the independent MobileExample build fresh**

Run:

```sh
xcodebuild -project Examples/MobileExample/MobileExample.xcodeproj -scheme MobileExample -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5' build
```

Expected: exit 0 with `** BUILD SUCCEEDED **`.

- [ ] **Step 6: Review the implementation against the approved spec**

Invoke `superpowers:requesting-code-review` and require the review to check:

```text
- No compatibility declarations or unprefixed ButtonStyle factories remain.
- Badge and Button rendering logic changed only in terminology.
- Every existing demo and README snippet uses the v1 API.
- SettingsFormUseCase uses all required public APIs and local state only.
- SU-003 navigation reorganization and SU-004 behavior work were not pulled forward.
```

Expected: no unresolved P0/P1 findings. Fix any finding with a new failing test when it identifies behavior or API regression, then rerun Steps 1–5.

- [ ] **Step 7: Record exact evidence and advance the roadmap**

In `ROADMAP.md`:

```yaml
current_phase: foundation
current_focus: SU-003
```

Set `SU-002` to `done` and replace its empty evidence with:

```yaml
evidence:
  - "2026-08-04: ./Scripts/verify ios --profile minimum --output json passed on iPhone 16 Pro with iOS 18.5."
  - "Tests: PublicContractTests 4 passed; ThemeEnvironmentTests 2 passed."
  - "API inventory: zero executable-source matches for SteadyBadgeStyle, SteadyBadgeType, SteadyCTAButonStyle, SteadyButtonType, .cta, .text, or .underline factories."
  - "MobileExample: iPhone 16 Pro iOS 18.5 build passed with SettingsFormUseCase linked from RootView."
  - "Review: Superpowers code review completed with no unresolved P0/P1 findings."
  - "Files: README.md, ROADMAP.md, Sources/SteadyUI Badge and Button APIs, Tests/SteadyUITests/PublicContractTests.swift, and MobileExample demos/use case."
```

Set `SU-003` from `planned` to `ready`. Do not change any later item.

- [ ] **Step 8: Commit roadmap completion evidence**

```sh
git add ROADMAP.md
git commit -m "docs: record SU-002 verification evidence"
```

- [ ] **Step 9: Re-run the completion checks after the evidence commit**

Run:

```sh
git status --short
./Scripts/verify ios --profile minimum --output json
xcodebuild -project Examples/MobileExample/MobileExample.xcodeproj -scheme MobileExample -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5' build
```

Expected: clean status, iOS gate exit 0 with `status: passed`, and MobileExample `** BUILD SUCCEEDED **`.
