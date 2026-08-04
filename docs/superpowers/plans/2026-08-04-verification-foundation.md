# SteadyUI Verification Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 로드맵 병합 이후 첫 구현 PR에서 작업 제어 문서, iOS 테스트 타깃, 재현 가능한 검증 진입점, 배포 하한, GitHub Actions 게이트를 하나의 동작하는 수직 슬라이스로 연결한다.

**Architecture:** 루트 ROADMAP.md와 AGENTS.md가 작업 선택 및 상태의 제어 계층을 담당하고, Swift Testing 타깃이 제품 계약을 검증한다. Foundation 기반 단일 Swift 스크립트 Scripts/verify가 환경 검사, SwiftPM Xcode workspace 준비, runtime별 simulator UDID 선택, XcodeBuildMCP 실행, JSON 결과 생성을 조정하며 로컬과 CI가 같은 진입점을 사용한다.

**Tech Stack:** Swift 6.3.1, Swift Testing, Swift Package Manager, SwiftUI, Xcode 26.4.1, XcodeBuildMCP 2.1.0, GitHub Actions macOS 26

## Global Constraints

- Package와 MobileExample의 최소 배포 버전은 iOS 18.0이다.
- minimum 프로필은 iOS 18.5의 iPhone 16 Pro다.
- ci 프로필은 iOS 26.4의 iPhone 17 Pro다.
- Xcode 26.4.1, Swift 6.3.1, iOS Simulator SDK 26.4, XcodeBuildMCP 2.1.0을 정확히 검사한다.
- 같은 이름의 simulator가 여러 runtime에 있으므로 runtime 구간에서 UDID를 해석하고 --simulator-id로 테스트한다.
- Scripts/verify는 Foundation 외의 런타임 의존성을 갖지 않는다.
- swift test는 host 진단이며 CI 또는 릴리스 게이트가 아니다.
- 공개 API 이름, 기존 컴포넌트 동작 및 시각, 신규 컴포넌트, DocC, 스냅샷 테스트는 변경하지 않는다.
- 검증 근거가 없는 로드맵 항목은 done으로 바꾸지 않는다.

---

## File Map

- Create ROADMAP.md: 10주 작업 ID, 상태, 의존성, 완료 조건, 검증, 근거
- Create AGENTS.md: 작업 선택, TDD, UI 추상화, 검증 및 상태 갱신 규칙
- Create README.md: 요구 환경과 로컬/CI 검증 방법
- Create Tests/SteadyUITests/ThemeEnvironmentTests.swift: Theme environment 기본값과 override 계약
- Create Tests/SteadyUITests/PublicContractTests.swift: Equatable 및 Sendable 계약
- Create Scripts/verify: environment, host, ios 명령과 JSON 출력
- Create .github/workflows/verify.yml: ci 프로필과 artifact
- Modify Package.swift: SteadyUITests 타깃
- Modify Examples/MobileExample/MobileExample.xcodeproj/project.pbxproj: 네 배포 하한
- Do not modify Sources/SteadyUI/** or MobileExample demo source.

---

### Task 1: Operationalize the Roadmap and Agent Rules

**Files:**
- Create: ROADMAP.md
- Create: AGENTS.md

**Interfaces:**
- Consumes: docs/superpowers/specs/2026-08-03-steady-ui-roadmap-design.md
- Produces: SU-001~SU-010 작업 그래프와 이후 Task가 상태 및 evidence를 기록할 위치

- [ ] **Step 1: 문서가 아직 없음을 검증한다**

Run:

~~~~bash
test ! -e ROADMAP.md
test ! -e AGENTS.md
~~~~

Expected: 두 명령 모두 exit 0.

- [ ] **Step 2: ROADMAP.md 상단과 상태 계약을 작성한다**

~~~~markdown
# SteadyUI Roadmap

~~~~yaml
roadmap_version: 1
last_updated: 2026-08-04
horizon: 10-weeks
current_phase: foundation
current_focus: SU-001
owner: repository-maintainer
~~~~

허용 상태는 planned, ready, in_progress, blocked, done, deferred다. 모든 depends_on이 done일 때만 ready가 될 수 있고, 검증 결과가 evidence에 기록된 경우에만 done이 될 수 있다.
~~~~

- [ ] **Step 3: SU-001을 전체 필드로 작성한다**

~~~~yaml
id: SU-001
title: Establish the verification foundation
status: in_progress
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
evidence: []
~~~~

- [ ] **Step 4: SU-002~SU-010을 같은 필드 구조로 작성한다**

다음 표의 값을 사용한다. 모든 항목에 goal, preferred_abstraction, abstraction_rationale, mobile_example_use_cases, acceptance, verification, evidence를 포함한다. verification에는 항상 ./Scripts/verify ios --profile minimum --output json을 포함한다.

| ID | title | status | priority | phase | depends_on | 필수 acceptance |
| --- | --- | --- | --- | --- | --- | --- |
| SU-002 | Normalize the v1 public API baseline | planned | P0 | foundation | SU-001 | 전환표 적용, 이전 네 이름 제거, Sources와 MobileExample 동시 컴파일 |
| SU-003 | Define tokens and component contracts | planned | P0 | foundation | SU-002 | 상태·크기·모션·접근성·추상화 템플릿, Components/Use Cases 구조 |
| SU-004 | Stabilize actions and add checkbox | planned | P0 | actions | SU-003 | ButtonStyle 상태, Checkbox ToggleStyle, Settings Form |
| SU-005 | Complete inputs and selection | planned | P0 | inputs | SU-004 | TextFieldStyle, Radio, SteadyToggle 유지, Switch Tab 보강 |
| SU-006 | Add content foundations | planned | P1 | content | SU-005 | Icon 규칙, Divider/Card modifier, Avatar, Badge |
| SU-007 | Add chip and composition quality | planned | P1 | selection | SU-006 | Chip style, overflow, RTL, Dynamic Type, API 일관성 |
| SU-008 | Add feedback components | planned | P1 | feedback | SU-007 | ProgressViewStyle, Skeleton modifier, Banner, Empty State |
| SU-009 | Validate internal adoption and freeze API | planned | P0 | integration | SU-008 | 사내 화면 2개, 우회 스타일 감사, 성능 기준선, API 동결 |
| SU-010 | Complete release documentation and v1.0 gates | planned | P0 | release | SU-009 | README, DocC, CONTRIBUTING, CHANGELOG, LICENSE 승인, RC/1.0 체크리스트 |

UI 항목의 mobile_example_use_cases에는 기존 설계의 Settings Form, Authentication Form, Content Card or Dashboard, Loading/Error/Empty Feedback Flow를 해당 주차와 동일하게 기록한다. preferred_abstraction과 rationale도 기존 설계 표의 Style/Modifier/View 결정을 그대로 옮긴다.

필드 값을 해석에 맡기지 않도록 다음 매핑을 사용한다.

| ID | goal | preferred_abstraction | abstraction_rationale | mobile_example_use_cases |
| --- | --- | --- | --- | --- |
| SU-002 | Establish the source-compatible v1 naming baseline before adding components. | api-design | No release tag exists, so Sources and MobileExample can migrate together without compatibility wrappers. | Settings Form |
| SU-003 | Define the design, state, accessibility, and example contract every public UI API must follow. | design-contracts | This item defines cross-component rules and does not render UI. | Settings Form |
| SU-004 | Make action styles complete and add accessible binary selection. | ButtonStyle, ToggleStyle | Native styles preserve Button and Toggle action, binding, role, and accessibility semantics. | Settings Form |
| SU-005 | Complete the minimum accessible form controls. | TextFieldStyle, ToggleStyle, top-level composition View | Native styles preserve input and selection semantics; SteadyToggle remains the approved custom View for direct track, thumb, and motion control. | Authentication Form, Settings Form |
| SU-006 | Provide low-level content primitives for common screens. | ViewModifier, top-level custom View | Divider and Card decorate arbitrary content, while Avatar and Badge own unique content structure. | Content Card or Dashboard |
| SU-007 | Provide stateful chip selection and validate composition under constrained layouts. | ToggleStyle, ButtonStyle | Persistent selection uses Toggle semantics and one-shot actions use Button semantics. | Content Card or Dashboard |
| SU-008 | Express loading, warning, error, and empty states consistently. | ProgressViewStyle, ViewModifier, top-level custom View | Native ProgressView keeps progress semantics, Skeleton decorates content, and Banner/Empty State own content structure. | Loading/Error/Empty Feedback Flow |
| SU-009 | Validate release-candidate APIs in real internal screens and produce the API freeze candidate. | product-integration | This item evaluates consumers and does not introduce a new rendering abstraction. | Settings Form, Authentication Form, Content Card or Dashboard, Loading/Error/Empty Feedback Flow |
| SU-010 | Make adoption and release reproducible for an external consumer. | documentation, release-tooling | This item packages verified APIs and does not introduce a new rendering abstraction. | Settings Form, Authentication Form, Content Card or Dashboard, Loading/Error/Empty Feedback Flow |

- [ ] **Step 5: AGENTS.md를 작성한다**

다음 네 섹션과 규칙을 정확히 포함한다.

~~~~markdown
# SteadyUI Agent Instructions

## Before Starting
1. Read the roadmap design, ROADMAP.md, and the current item.
2. Select only the highest-priority ready item whose dependencies are all done.
3. Keep at most one item in_progress.
4. Mark ambiguous scope, API, abstraction, or acceptance blocked and record the exact question.

## Implementation Order
1. Write the smallest failing test.
2. Run it and preserve the expected failure.
3. Implement the minimum passing change.
4. Refactor without changing behavior.
5. Update documentation, an independent demo, and a required use case together.
6. Run the item's verification commands.

## UI Abstraction
1. Prefer a native SwiftUI Style.
2. Use ViewModifier for reusable decoration or cross-cutting behavior.
3. Use a top-level custom View only for unique structure or coordination and record the rationale.
4. Keep SteadyToggle as the approved custom View.
5. Keep renderable public types at module top level with the Steady prefix.

## Completion
1. Confirm every applicable public UI completion criterion.
2. Record the exact command, result, affected files, and CI/review link in evidence.
3. Mark done only after acceptance passes and evidence exists.
4. Recompute current_phase/current_focus and mark the next dependency-satisfied item ready.
5. Do not lower test, accessibility, documentation, or evidence gates.
~~~~

- [ ] **Step 6: 구조를 검증한다**

~~~~bash
rg -n '^current_focus: SU-001$|^id: SU-00[1-9]$|^id: SU-010$|^evidence:' ROADMAP.md
rg -n '^## Before Starting$|^## Implementation Order$|^## UI Abstraction$|^## Completion$' AGENTS.md
~~~~

Expected: SU-001~SU-010이 각각 한 번, 네 AGENTS 섹션이 각각 한 번 나온다.

- [ ] **Step 7: 커밋한다**

~~~~bash
git add ROADMAP.md AGENTS.md
git commit -m "docs: operationalize SteadyUI roadmap"
~~~~

---

### Task 2: Add the First iOS Test Contracts and Align Deployment Floors

**Files:**
- Create: Tests/SteadyUITests/ThemeEnvironmentTests.swift
- Create: Tests/SteadyUITests/PublicContractTests.swift
- Modify: Package.swift
- Modify: Examples/MobileExample/MobileExample.xcodeproj/project.pbxproj

**Interfaces:**
- Consumes: EnvironmentValues.theme, SteadyTheme, ColorTokens, FontTokens, RadiusTokens, SpacingTokens
- Produces: SteadyUITests 타깃과 iOS 18.0으로 통일된 네 build setting

- [ ] **Step 1: 실패할 Theme environment 테스트를 작성한다**

~~~~swift
import SteadyUI
import SwiftUI
import Testing

@Suite("Theme environment")
struct ThemeEnvironmentTests {
  @Test("environment uses the default theme")
  func environmentUsesDefaultTheme() {
    let values = EnvironmentValues()

    #expect(values.theme == .default)
  }

  @Test("environment preserves a theme override")
  func environmentPreservesThemeOverride() {
    var expected = SteadyTheme.default
    expected.spacing.large = 37
    var values = EnvironmentValues()

    values.theme = expected

    #expect(values.theme == expected)
  }
}
~~~~

- [ ] **Step 2: 실패할 공개 타입 계약 테스트를 작성한다**

~~~~swift
import SteadyUI
import Testing

@Suite("Public contracts")
struct PublicContractTests {
  @Test("theme equality observes token changes")
  func themeEqualityObservesTokenChanges() {
    var modified = SteadyTheme.default
    modified.spacing.large += 1

    #expect(modified != SteadyTheme.default)
  }

  @Test("theme and token groups remain Equatable and Sendable")
  func themeAndTokenContracts() {
    requireEquatableAndSendable(SteadyTheme.self)
    requireEquatableAndSendable(ColorTokens.self)
    requireEquatableAndSendable(FontTokens.self)
    requireEquatableAndSendable(RadiusTokens.self)
    requireEquatableAndSendable(SpacingTokens.self)
  }

  private func requireEquatableAndSendable<Value: Equatable & Sendable>(
    _: Value.Type
  ) {}
}
~~~~

- [ ] **Step 3: 테스트 타깃 부재를 확인한다**

Run:

~~~~bash
xcodebuildmcp project-discovery list-schemes --workspace-path .swiftpm/xcode/package.xcworkspace --output json
~~~~

Expected: 새 테스트 파일을 실행할 SteadyUITests 타깃이 없다.

- [ ] **Step 4: Package.swift에 테스트 타깃을 추가한다**

~~~~swift
targets: [
  .target(
    name: "SteadyUI"
  ),
  .testTarget(
    name: "SteadyUITests",
    dependencies: ["SteadyUI"]
  ),
],
~~~~

- [ ] **Step 5: 네 MobileExample 배포 하한을 수정한다**

PBXProject Debug/Release의 26.4 두 곳과 PBXNativeTarget Debug/Release의 18.6 두 곳을 모두 다음 값으로 바꾼다.

~~~~text
IPHONEOS_DEPLOYMENT_TARGET = 18.0;
~~~~

다른 build setting은 변경하지 않는다.

- [ ] **Step 6: iOS 18.5에서 테스트한다**

먼저 xcodebuildmcp simulator list --output json에서 iOS 18.5 구간의 iPhone 16 Pro UDID를 읽는다. 현재 확인값은 BB71DA41-A3DA-491A-940D-37D5B31C9C0E지만 실행 시 출력이 다르면 실제 값을 사용한다.

~~~~bash
xcodebuildmcp simulator test --workspace-path .swiftpm/xcode/package.xcworkspace --scheme SteadyUI --simulator-id BB71DA41-A3DA-491A-940D-37D5B31C9C0E --configuration Debug --output json
~~~~

Expected: ThemeEnvironmentTests 2개와 PublicContractTests 2개가 PASS.

- [ ] **Step 7: 배포 하한과 제품 소스 비변경을 검증한다**

~~~~bash
rg -n 'IPHONEOS_DEPLOYMENT_TARGET = ' Examples/MobileExample/MobileExample.xcodeproj/project.pbxproj
git diff --name-only HEAD -- Sources/SteadyUI
~~~~

Expected: 네 값 모두 18.0, 두 번째 명령은 출력 없음.

- [ ] **Step 8: 커밋한다**

~~~~bash
git add Package.swift Tests/SteadyUITests Examples/MobileExample/MobileExample.xcodeproj/project.pbxproj
git commit -m "test: establish iOS package contracts"
~~~~

---

### Task 3: Build the Thin Verification Entry Point

**Files:**
- Create: Scripts/verify

**Interfaces:**
- Consumes: xcodebuild, swift, xcrun, xcodebuildmcp, Package.swift, MobileExample project
- Produces: environment/host/ios 명령, minimum/ci 프로필, stdout의 단일 JSON, .build/verification/xcodebuildmcp-minimum.json 또는 xcodebuildmcp-ci.json

- [ ] **Step 1: 진입점 부재를 확인한다**

~~~~bash
./Scripts/verify environment --profile minimum --output json
~~~~

Expected: exit 127 또는 No such file or directory.

- [ ] **Step 2: CLI와 결과 타입을 작성한다**

Scripts/verify는 #!/usr/bin/env swift와 import Foundation으로 시작한다. 다음 타입을 사용한다.

~~~~swift
enum VerifyCommand: String, Codable { case environment, host, ios }
enum VerifyProfile: String, Codable {
  case minimum, ci
  var runtime: String { self == .minimum ? "18.5" : "26.4" }
  var simulator: String { self == .minimum ? "iPhone 16 Pro" : "iPhone 17 Pro" }
}
struct CheckResult: Codable {
  let name: String
  let expected: String
  let actual: String
  let passed: Bool
}
struct VerificationResult: Codable {
  let schemaVersion: Int
  let command: VerifyCommand
  let profile: VerifyProfile?
  let isGate: Bool
  let status: String
  let exitCode: Int32
  let checks: [CheckResult]
  let executedCommands: [[String]]
  let failureReason: String?
  let artifactPaths: [String]
}
struct ProcessResult {
  let command: [String]
  let exitCode: Int32
  let standardOutput: String
  let standardError: String
}
~~~~

Parser rules:

- 첫 positional은 environment, host, ios 중 하나다.
- --output json은 필수이고 다른 output은 exit 64다.
- environment와 ios는 --profile minimum 또는 ci 하나가 필수다.
- host는 --profile을 거부한다.
- 알 수 없거나 중복된 flag는 exit 64의 JSON 실패다.
- JSONEncoder는 prettyPrinted, sortedKeys, withoutEscapingSlashes와 convertToSnakeCase를 사용한다.
- stdout에는 JSON 하나만 쓰고 진행 로그는 stderr에 쓴다.

- [ ] **Step 3: 교착 없는 하위 프로세스 실행기를 작성한다**

~~~~swift
func run(
  _ executable: String,
  _ arguments: [String],
  currentDirectory: URL
) throws -> ProcessResult
~~~~

/usr/bin/xcodebuild, /usr/bin/swift, /usr/bin/xcrun을 절대 경로로 실행하고 XcodeBuildMCP는 /usr/bin/env xcodebuildmcp로 실행한다. 긴 Xcode 출력이 Pipe를 채우지 않도록 stdout/stderr를 FileManager.default.temporaryDirectory 아래의 서로 다른 임시 파일에 연결한다. waitUntilExit 후 handle을 닫고 UTF-8로 읽으며 defer에서 임시 디렉터리를 제거한다. Process.run 오류에는 전체 명령과 Foundation 오류를 포함한다.

- [ ] **Step 4: 환경 검사와 runtime별 UDID 해석을 작성한다**

~~~~swift
func inspectEnvironment(
  profile: VerifyProfile,
  repositoryRoot: URL
) throws -> (
  checks: [CheckResult],
  commands: [[String]],
  simulatorID: String?
)
~~~~

검사값은 다음과 같다.

| name | source | expected |
| --- | --- | --- |
| xcode | xcodebuild -version 첫 줄 | Xcode 26.4.1 |
| swift | swift --version 첫 줄 | Apple Swift version 6.3.1 포함 |
| ios_simulator_sdk | xcrun --sdk iphonesimulator --show-sdk-version | 26.4 |
| xcodebuildmcp | xcodebuildmcp --version | 2.1.0 |
| package_deployment_target | Package.swift | .iOS(.v18) 한 번 |
| mobile_example_deployment_targets | PBX regex | 네 값 모두 18.0 |
| simulator | XcodeBuildMCP list의 runtime 구간 | 프로필 device와 UUID |

UDID helper는 runtime header com.apple.CoreSimulator.SimRuntime.iOS-18-5: 또는 iOS-26-4: 뒤부터 다음 runtime header 전까지만 검색한다. 그 구간에서 정규식 - DEVICE_NAME \\(([0-9A-Fa-f-]{36})\\)의 capture를 반환한다. 전체 출력에서 device 이름과 runtime을 독립적으로 검색하지 않는다.

- [ ] **Step 5: environment 성공과 parser 실패를 검증한다**

환경 mismatch는 status failed, exit 78, 실패 check 이름을 failureReason에 기록한다. 성공은 status passed, exit 0이다.

~~~~bash
chmod +x Scripts/verify
./Scripts/verify environment --profile minimum --output json > /private/tmp/steady-ui-environment.json
plutil -lint /private/tmp/steady-ui-environment.json
~~~~

Expected: exit 0, JSON OK, iOS 18.5 iPhone 16 Pro UUID 포함.

~~~~bash
./Scripts/verify environment --profile unsupported --output json > /private/tmp/steady-ui-invalid.json
~~~~

Expected: exit 64, stdout는 유효한 JSON이고 허용 프로필을 설명한다.

- [ ] **Step 6: host 진단을 구현하고 검증한다**

/usr/bin/swift test를 정확히 실행한다. isGate는 false이고 child exit code를 그대로 반환한다. 실패해도 stdout JSON을 완성하고 stderr 요약을 failureReason에 넣는다. ios나 CI에서 host를 호출하지 않는다.

~~~~bash
./Scripts/verify host --output json > /private/tmp/steady-ui-host.json
plutil -lint /private/tmp/steady-ui-host.json
~~~~

Expected: 실제 swift test 결과와 무관하게 stdout JSON은 유효하고 is_gate는 false다.

- [ ] **Step 7: workspace bootstrap과 ios 실행을 구현한다**

~~~~swift
func prepareWorkspace(repositoryRoot: URL) throws -> URL {
  let workspace = repositoryRoot
    .appendingPathComponent(".swiftpm/xcode/package.xcworkspace", isDirectory: true)
  let contents = workspace.appendingPathComponent("contents.xcworkspacedata")
  let xml = """
  <?xml version="1.0" encoding="UTF-8"?>
  <Workspace
     version = "1.0">
     <FileRef
        location = "self:">
     </FileRef>
  </Workspace>

  """
  try FileManager.default.createDirectory(
    at: workspace,
    withIntermediateDirectories: true
  )
  if !FileManager.default.fileExists(atPath: contents.path) {
    try Data(xml.utf8).write(to: contents, options: .atomic)
  }
  return workspace
}
~~~~

ios는 environment 실패나 UDID 부재 시 exit 78로 멈춘다. 성공하면 unwrap한 simulatorID로 다음 인수 배열을 구성한다.

~~~~swift
let arguments = [
  "xcodebuildmcp", "simulator", "test",
  "--workspace-path", ".swiftpm/xcode/package.xcworkspace",
  "--scheme", "SteadyUI",
  "--simulator-id", simulatorID,
  "--configuration", "Debug",
  "--output", "json",
]
~~~~

원본 stdout을 .build/verification/xcodebuildmcp-minimum.json 또는 xcodebuildmcp-ci.json에 atomic write하고 artifactPaths에 상대 경로를 넣는다. child exit code를 숨기지 않는다.

- [ ] **Step 8: 무시된 workspace를 제거한 상태에서 minimum을 검증한다**

~~~~bash
mv .swiftpm/xcode/package.xcworkspace /private/tmp/steady-ui-package.xcworkspace
./Scripts/verify ios --profile minimum --output json > /private/tmp/steady-ui-ios-minimum.json
test -f .swiftpm/xcode/package.xcworkspace/contents.xcworkspacedata
plutil -lint /private/tmp/steady-ui-ios-minimum.json
plutil -lint .build/verification/xcodebuildmcp-minimum.json
~~~~

Expected: workspace 재생성, 네 테스트 PASS, 두 JSON 유효.

- [ ] **Step 9: 범위와 형식을 검증한다**

~~~~bash
rg -n '^import ' Scripts/verify
git diff --check
~~~~

Expected: import Foundation 하나, whitespace 오류 없음.

- [ ] **Step 10: 커밋한다**

~~~~bash
git add Scripts/verify
git commit -m "build: add reproducible iOS verification"
~~~~

---

### Task 4: Connect GitHub Actions and Contributor Documentation

**Files:**
- Create: .github/workflows/verify.yml
- Create: README.md

**Interfaces:**
- Consumes: Scripts/verify ios --profile ci --output json
- Produces: Verify / iOS job과 verification-results artifact

- [ ] **Step 1: workflow가 아직 없음을 확인한다**

~~~~bash
test ! -e .github/workflows/verify.yml
~~~~

Expected: exit 0.

- [ ] **Step 2: workflow를 작성한다**

~~~~yaml
name: Verify

on:
  pull_request:
  push:
    branches:
      - main

permissions:
  contents: read

jobs:
  ios:
    name: iOS
    runs-on: macos-26
    timeout-minutes: 30
    steps:
      - name: Check out repository
        uses: actions/checkout@v4
      - name: Select Xcode 26.4.1
        run: sudo xcode-select --switch /Applications/Xcode_26.4.1.app
      - name: Install XcodeBuildMCP 2.1.0
        run: npm install --global xcodebuildmcp@2.1.0
      - name: Verify iOS package
        run: |
          mkdir -p .build/verification
          ./Scripts/verify ios --profile ci --output json > .build/verification/verify-ci.json
      - name: Upload verification results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: verification-results
          path: .build/verification
          if-no-files-found: warn
          retention-days: 14
~~~~

- [ ] **Step 3: workflow 문법과 고정값을 검증한다**

~~~~bash
ruby -e 'require "yaml"; YAML.load_file(".github/workflows/verify.yml")'
rg -n 'macos-26|Xcode_26\.4\.1|xcodebuildmcp@2\.1\.0|Scripts/verify ios --profile ci|if: always' .github/workflows/verify.yml
~~~~

Expected: YAML parse exit 0, 모든 고정값 발견.

- [ ] **Step 4: README.md를 작성한다**

다음 섹션을 정확히 포함한다.

- SteadyUI는 iOS 18+ SwiftUI package이며 pre-1.0이라는 소개
- Requirements: Xcode 26.4.1, Swift 6.3.1, iOS 18+, XcodeBuildMCP 2.1.0
- Add the Package: 첫 tag 전에는 Xcode local package로 추가
- Apply the Default Theme: ContentView().environment(\.theme, .default) 예제
- Verify Changes: 아래 네 명령
- Roadmap: ROADMAP.md와 AGENTS.md 링크

~~~~bash
./Scripts/verify environment --profile minimum --output json
./Scripts/verify ios --profile minimum --output json
./Scripts/verify ios --profile ci --output json
./Scripts/verify host --output json
~~~~

host는 진단 전용이고 merge/release gate가 아니라고 명시한다.

- [ ] **Step 5: README 계약을 검증한다**

~~~~bash
rg -n 'Xcode 26\.4\.1|Swift 6\.3\.1|iOS 18|XcodeBuildMCP 2\.1\.0' README.md
rg -n 'Scripts/verify (environment|ios) --profile minimum --output json|Scripts/verify ios --profile ci --output json|Scripts/verify host --output json' README.md
~~~~

Expected: 환경 4개와 공개 명령 4개 모두 발견.

- [ ] **Step 6: minimum을 다시 실행한다**

~~~~bash
./Scripts/verify ios --profile minimum --output json > /private/tmp/steady-ui-ios-after-docs.json
plutil -lint /private/tmp/steady-ui-ios-after-docs.json
~~~~

Expected: exit 0, JSON valid, 네 테스트 PASS.

- [ ] **Step 7: 커밋한다**

~~~~bash
git add .github/workflows/verify.yml README.md
git commit -m "ci: verify SteadyUI on every pull request"
~~~~

---

### Task 5: Verify a Clean Checkout and Record Evidence

**Files:**
- Modify: ROADMAP.md

**Interfaces:**
- Consumes: Tasks 1~4, 성공한 minimum 결과, 성공한 Verify workflow
- Produces: SU-001 done evidence, SU-002 ready

- [ ] **Step 1: 깨끗한 작업 트리를 확인한다**

~~~~bash
git status --short
git log --oneline origin/main..HEAD
~~~~

Expected: worktree clean, 설계/계획 커밋과 Tasks 1~4 커밋만 표시.

- [ ] **Step 2: 추적 파일만 임시 디렉터리에 푼다**

~~~~bash
verification_checkout="$(mktemp -d /private/tmp/steady-ui-verify.XXXXXX)"
git archive --format=tar --output=/private/tmp/steady-ui-verification.tar HEAD
tar -xf /private/tmp/steady-ui-verification.tar -C "$verification_checkout"
cd "$verification_checkout"
~~~~

verification_checkout은 이 작업 전용 변수이며 mktemp가 반환한 검증 복사본만 가리킨다.

- [ ] **Step 3: 깨끗한 복사본에서 minimum을 검증한다**

Run from the extracted directory:

~~~~bash
test ! -e .swiftpm/xcode/package.xcworkspace/contents.xcworkspacedata
./Scripts/verify ios --profile minimum --output json > verification-minimum.json
test -f .swiftpm/xcode/package.xcworkspace/contents.xcworkspacedata
plutil -lint verification-minimum.json
plutil -lint .build/verification/xcodebuildmcp-minimum.json
~~~~

Expected: workspace 생성, 네 테스트 PASS, JSON 유효.

- [ ] **Step 4: push해 CI를 실행한다**

~~~~bash
git push --set-upstream origin feature/verification-foundation
~~~~

Expected: Verify / iOS job 시작.

- [ ] **Step 5: CI 결과를 기다린다**

~~~~bash
gh run list --workflow verify.yml --branch feature/verification-foundation --limit 1
gh run watch "$(gh run list --workflow verify.yml --branch feature/verification-foundation --limit 1 --json databaseId --jq '.[0].databaseId')" --exit-status
~~~~

Expected: exit 0, verification-results에 verify-ci.json과 xcodebuildmcp-ci.json 존재.

- [ ] **Step 6: 실제 CI URL을 얻어 ROADMAP.md를 완료한다**

~~~~bash
gh run list --workflow verify.yml --branch feature/verification-foundation --status success --limit 1 --json url --jq '.[0].url'
~~~~

반환된 실제 URL을 SU-001 evidence에 기록한다. 같은 evidence 배열에 다음을 기록한다.

- 2026-08-04 깨끗한 archive에서 minimum 성공
- ThemeEnvironmentTests 2개와 PublicContractTests 2개 성공
- 변경 파일: Package.swift, MobileExample project, Scripts/verify, workflow, README, ROADMAP, AGENTS

SU-001을 done, SU-002를 ready, current_focus를 SU-002로 바꾸고 current_phase는 foundation으로 유지한다.

- [ ] **Step 7: 로드맵 상태를 검증한다**

~~~~bash
rg -n '^current_focus: SU-002$|^id: SU-001$|^status: done$|^id: SU-002$|^status: ready$|https://github.com/thesteadycompany/steady-ui/actions/runs/' ROADMAP.md
git diff --check
~~~~

Expected: SU-001 done, SU-002 ready, 실제 Actions URL, whitespace 오류 없음.

- [ ] **Step 8: evidence를 커밋하고 최종 CI를 확인한다**

~~~~bash
git add ROADMAP.md
git commit -m "docs: record verification foundation evidence"
git push
~~~~

마지막 문서 커밋의 Verify / iOS도 성공해야 한다. 기능 커밋의 성공 URL은 evidence에 유지하고 최종 run URL은 PR 설명에 기록한다.

---

## Final Self-Review

- [ ] **Step 1: 변경 파일 범위를 확인한다**

~~~~bash
git diff --name-only origin/main...HEAD
git diff --exit-code origin/main...HEAD -- Sources/SteadyUI
~~~~

Expected: 설계/계획 문서와 계획에 열거한 파일만 표시되고 Sources/SteadyUI diff는 없다.

- [ ] **Step 2: 전체 로컬 게이트를 새로 실행한다**

~~~~bash
./Scripts/verify environment --profile minimum --output json > /private/tmp/steady-ui-final-environment.json
./Scripts/verify ios --profile minimum --output json > /private/tmp/steady-ui-final-ios.json
plutil -lint /private/tmp/steady-ui-final-environment.json
plutil -lint /private/tmp/steady-ui-final-ios.json
git diff --check origin/main...HEAD
~~~~

Expected: 모든 명령 exit 0.

- [ ] **Step 3: PR 완료 조건을 확인한다**

- minimum 로컬 성공 근거가 있다.
- ci GitHub Actions 성공 링크가 있다.
- CI artifact가 실패 시에도 업로드된다.
- 깨끗한 checkout에서 workspace가 생성된다.
- 모든 deployment target이 iOS 18.0이다.
- 네 Swift Testing 테스트가 통과한다.
- SU-001은 done, SU-002는 ready다.
- 공개 API와 컴포넌트 변경이 없다.
