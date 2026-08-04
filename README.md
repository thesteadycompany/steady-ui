# SteadyUI

SteadyUI is a SwiftUI design-system package for iOS 18 and later. The package is in pre-1.0 development and validates new APIs in the bundled MobileExample before release.

## Requirements

- Xcode 26.4.1
- Swift 6.3.1
- iOS 18 or later
- XcodeBuildMCP 2.1.0 for repository verification

## Add the Package

Until the first tagged release, add this repository as a local Swift package in Xcode and import the library where it is used:

```swift
import SteadyUI
```

## Apply the Default Theme

```swift
import SteadyUI
import SwiftUI

@main
struct ExampleApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.theme, .default)
    }
  }
}
```

## Verify Changes

Run the minimum supported runtime before requesting review:

```bash
./Scripts/verify environment --profile minimum --output json
./Scripts/verify ios --profile minimum --output json
```

GitHub Actions runs the same entry point with the hosted-runner profile:

```bash
./Scripts/verify ios --profile ci --output json
```

`./Scripts/verify host --output json` records the result of `swift test` for diagnostics. SteadyUI is iOS-only, so the host command is not a merge or release gate.

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the current item, dependencies, acceptance criteria, and verification evidence. Contributors and agents must also follow [AGENTS.md](AGENTS.md).

