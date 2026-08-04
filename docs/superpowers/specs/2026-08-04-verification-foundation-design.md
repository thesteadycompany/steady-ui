# SteadyUI 검증 기반 PR 설계

**상태:** 사용자 승인 완료

**작성일:** 2026-08-04

**대상:** 로드맵 병합 이후 첫 구현 PR

## 1. 목표

10주 로드맵을 사람이 읽는 설계에서 개발자, AI, CI가 동일한 절차로 실행하고 검증할 수 있는 작업 체계로 전환한다.

이 PR은 검증 기반만 책임진다. 공개 API 이름 변경, 기존 컴포넌트 수정, 신규 컴포넌트, DocC, 스냅샷 테스트는 후속 PR로 분리한다.

## 2. 선택한 접근

### 검증 기반의 수직 슬라이스

루트 작업 문서, 첫 테스트 타깃, 단일 검증 진입점, 예제 앱의 배포 하한, CI를 한 PR에서 연결한다. 이를 통해 다음 PR부터 로드맵 항목 선택, 구현, 로컬 및 CI 검증, 완료 근거 기록까지 하나의 흐름으로 수행할 수 있다.

문서만 추가하는 접근은 실행 가능한 품질 게이트가 없으므로 선택하지 않았다. 로드맵 1주차 전체를 한 번에 구현하는 접근은 검증 인프라와 공개 API 변경이 섞여 리뷰 범위와 회귀 원인 분석이 불명확해지므로 선택하지 않았다.

## 3. 범위

### 포함

- 루트 `ROADMAP.md`에 10주 로드맵의 작업 ID, 상태, 우선순위, 의존성, 완료 조건, 검증 명령, 근거를 구조화한다.
- 루트 `AGENTS.md`에 다음 작업 선택, 단일 진행 항목, 테스트 우선 구현, 상태 전환, 근거 기록 규칙을 정의한다.
- 루트 `README.md`에 지원 환경과 로컬 검증 명령을 기록한다.
- `Package.swift`에 Swift Testing 기반 `SteadyUITests` 타깃을 추가한다.
- Theme environment의 기본값과 override, Theme equality, 핵심 타입 conformance를 검증하는 첫 테스트를 추가한다.
- `Examples/MobileExample/MobileExample.xcodeproj/project.pbxproj`의 프로젝트 및 앱 타깃 배포 하한을 모두 iOS 18.0으로 통일한다.
- `Scripts/verify`를 로컬과 CI의 단일 검증 진입점으로 추가한다.
- GitHub Actions에서 PR과 `main` 푸시마다 CI 검증 프로필을 실행하고 JSON 결과를 artifact로 보존한다.
- 성공한 로컬 최소 런타임 검증과 CI 실행 링크를 `ROADMAP.md`의 완료 근거에 기록한다.

### 제외

- `SteadyCTAButonStyle`을 포함한 공개 API 이름 변경
- 기존 컴포넌트의 동작 또는 시각 변경
- 신규 컴포넌트
- DocC, 스냅샷 테스트, 접근성 매트릭스 구현
- 외부 Swift Package 의존성
- self-hosted CI 러너 구성

## 4. 파일과 책임

### 작업 제어

- `ROADMAP.md`: 사람과 AI가 사용하는 작업 상태의 단일 진실 공급원
- `AGENTS.md`: 로드맵 항목 선택, 구현 순서, 검증, 상태 갱신 규칙
- `README.md`: 소비자와 기여자가 사용하는 요구 환경, 빠른 시작, 검증 명령

### 검증

- `Scripts/verify`: 환경 검사와 host/iOS 검증을 조정하고 구조화된 결과를 출력하는 얇은 실행 스크립트
- `Tests/SteadyUITests/ThemeEnvironmentTests.swift`: Theme environment 기본값과 override 검증
- `Tests/SteadyUITests/PublicContractTests.swift`: 핵심 Theme 및 토큰 타입의 `Equatable`, `Sendable` 계약 검증
- `.github/workflows/verify.yml`: 고정된 CI 프로필 실행과 결과 artifact 업로드

### 기존 설정

- `Package.swift`: `SteadyUITests` 테스트 타깃 선언
- `Examples/MobileExample/MobileExample.xcodeproj/project.pbxproj`: 프로젝트 및 앱 타깃의 Debug/Release 배포 하한을 iOS 18.0으로 통일

## 5. 검증 스크립트 계약

`Scripts/verify`는 Foundation만 사용하는 실행 가능한 Swift 스크립트다. 별도 라이브러리, 패키지 관리자, JSON 도구에 의존하지 않는다. 자체 빌드 시스템을 만들지 않고 검증에 필요한 기존 명령을 선택하고 결과와 종료 상태를 전달한다.

공개 명령은 다음과 같다.

```bash
./Scripts/verify environment --profile minimum --output json
./Scripts/verify environment --profile ci --output json
./Scripts/verify host --output json
./Scripts/verify ios --profile minimum --output json
./Scripts/verify ios --profile ci --output json
```

지원하지 않는 명령, 프로필, 출력 형식 또는 누락된 값은 사용법을 포함한 실패 결과를 출력하고 non-zero로 종료한다.

### `environment`

두 프로필 모두 다음 공통 조건을 검사한다.

- Xcode 26.4.1
- Swift 6.3.1
- iOS Simulator SDK 26.4
- XcodeBuildMCP 2.1.0
- Package 배포 하한 iOS 18.0
- MobileExample 프로젝트 및 앱 타깃의 Debug/Release 배포 하한 iOS 18.0

프로필별 시뮬레이터 조건은 다음과 같다.

| 프로필 | 런타임 | 시뮬레이터 | 용도 |
| --- | --- | --- | --- |
| `minimum` | iOS 18.5 | iPhone 16 Pro | 로컬 및 릴리스 최소 지원 검증 |
| `ci` | iOS 26.4 | iPhone 17 Pro | GitHub 호스티드 PR 검증 |

검사가 하나라도 실패하면 iOS 테스트를 시작하지 않는다.

### `host`

정확히 `swift test`를 실행한다. SteadyUI는 iOS 전용 패키지이므로 이 결과는 host 진단이며 CI 및 릴리스 게이트가 아니다. JSON 결과에 `is_gate: false`와 실제 종료 상태를 기록한다.

### `ios`

선택한 프로필의 `environment` 검사를 먼저 실행한다. 성공하면 `.swiftpm/xcode/package.xcworkspace`의 존재 여부를 검사한다. 이 파일은 Git에서 무시되고 `swift package resolve`만으로 생성되지 않으므로, 없을 때 다음 표준 `self:` 워크스페이스를 생성한다.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "self:">
   </FileRef>
</Workspace>
```

이 생성물은 `.swiftpm` 아래에 유지하고 Git에 추가하지 않는다. 이후 `xcodebuildmcp simulator list --output json` 결과에서 선택한 runtime 구간에 속한 simulator의 UDID를 해석한다. 같은 이름의 simulator가 여러 runtime에 존재할 수 있으므로 이름만으로 테스트 대상을 선택하지 않는다. 해석한 UDID로 다음 형태의 명령을 실행한다.

```bash
xcodebuildmcp simulator test \
  --workspace-path .swiftpm/xcode/package.xcworkspace \
  --scheme SteadyUI \
  --simulator-id "<resolved simulator UDID>" \
  --configuration Debug \
  --output json
```

스크립트는 XcodeBuildMCP의 성공 또는 실패를 숨기지 않고 같은 의미의 종료 상태로 반환한다.

### JSON 결과

`--output json`은 최소한 다음 정보를 포함한다.

- 스키마 버전
- 요청한 명령과 프로필
- gate 여부
- 전체 상태와 종료 코드
- 개별 환경 검사 이름, 기대값, 실제값, 상태
- 실행한 하위 명령
- 실패 원인
- 테스트 결과 artifact 경로

진행 로그는 표준 오류에 기록하고, 표준 출력에는 하나의 유효한 JSON 문서만 기록한다.

## 6. 테스트 설계

첫 테스트는 변경 의도가 분명하고 플랫폼 렌더링에 의존하지 않는 계약만 고정한다.

### Theme environment

- 새 `EnvironmentValues`가 `SteadyTheme.default`를 제공하는지 검증한다.
- 수정한 Theme를 `EnvironmentValues.theme`에 설정하면 소비자가 같은 값을 조회하는지 검증한다.
- 정확한 토큰 숫자를 고정하는 변경 감지 테스트는 작성하지 않는다. 이 PR은 소비자에게 보이는 environment 동작을 검증한다.

### 공개 타입 계약

컴파일 타임 generic helper를 사용해 다음 타입이 `Sendable`을 유지하는지 검증한다.

- `SteadyTheme`
- `ColorTokens`
- `FontTokens`
- `RadiusTokens`
- `SpacingTokens`

같은 타입이 공개 `Equatable` 계약을 유지하는지 컴파일 타임 helper로 검증하고, Theme의 한 토큰 그룹이 달라졌을 때 전체 Theme 비교가 달라지는지 테스트한다. 선언 이름 전체를 문자열로 스캔하는 API 인벤토리 테스트는 공개 API 이름을 정리하는 후속 PR에서 추가한다.

## 7. CI 설계

GitHub Actions는 PR과 `main` 브랜치 푸시에서 `macos-26` 러너를 사용한다.

1. `/Applications/Xcode_26.4.1.app`을 선택한다.
2. `npm install -g xcodebuildmcp@2.1.0`으로 CLI 버전을 고정한다.
3. `./Scripts/verify ios --profile ci --output json`을 실행하고 표준 출력을 결과 파일로 저장한다.
4. 성공 또는 실패와 관계없이 결과 JSON과 테스트 artifact를 업로드한다.

GitHub의 macOS 26 호스티드 이미지에는 Xcode 26.4.1과 iOS 26.x 런타임이 있지만 iOS 18.5 런타임은 없다. macOS 15 이미지에는 iOS 18.5가 있지만 Xcode 26.4.1과 Swift 6.3.1 조합이 없다. 따라서 모든 PR은 `ci` 프로필로 검증하고, `minimum` 프로필은 로컬 및 릴리스 게이트로 유지한다. 동일 환경의 self-hosted runner가 생기면 스크립트 변경 없이 `minimum` 프로필을 CI job에 추가한다.

참고 자료:

- [GitHub Actions macOS 26 이미지](https://github.com/actions/runner-images/blob/main/images/macos/macos-26-Readme.md)
- [GitHub Actions macOS 15 이미지](https://github.com/actions/runner-images/blob/main/images/macos/macos-15-Readme.md)
- [XcodeBuildMCP 설치 문서](https://www.xcodebuildmcp.com/docs/installation)

## 8. 오류 처리

- 환경 불일치와 제품 테스트 실패를 별도 검사 결과로 구분한다.
- 필요한 Xcode, SDK, CLI, runtime, simulator가 없으면 누락된 기대값과 실제 발견값을 출력한다.
- 워크스페이스 생성에 실패하면 테스트를 실행하지 않고 대상 경로와 파일 시스템 오류를 기록한다.
- 하위 프로세스 실행에 실패하면 실행한 명령, 종료 코드, 표준 오류 요약을 보존한다.
- `host` 실패는 iOS 게이트 상태에 영향을 주지 않는다.
- CI는 실패한 실행에서도 JSON을 artifact로 업로드해 원인 추적이 가능해야 한다.

## 9. 로드맵 상태와 근거

`ROADMAP.md`를 추가할 때 검증 기반 항목을 `in_progress`로 둔다. 다음 조건이 모두 충족된 뒤에만 `done`으로 전환한다.

- 깨끗한 체크아웃에서 `minimum` 프로필 성공
- GitHub Actions에서 `ci` 프로필 성공
- 성공한 명령, 날짜, 결과 요약 또는 artifact 경로 기록
- CI 실행 링크 기록
- 이 PR에서 생성하거나 변경한 파일 목록 기록

후속 최우선 `ready` 항목은 공개 API 인벤토리와 v1.0 이름 전환으로 둔다. 검증 근거가 없는 작업은 `done`으로 표시하지 않는다.

## 10. PR 완료 정의

- `ROADMAP.md`, `AGENTS.md`, `README.md`가 다음 작업과 검증 방법을 모호하지 않게 설명한다.
- 로컬 `./Scripts/verify ios --profile minimum --output json`이 iOS 18.5의 iPhone 16 Pro에서 성공한다.
- CI `./Scripts/verify ios --profile ci --output json`이 iOS 26.4의 iPhone 17 Pro에서 성공한다.
- 깨끗한 체크아웃에서 스크립트가 무시된 SwiftPM 워크스페이스를 준비하고 테스트를 실행한다.
- Theme environment 기본값/override, Theme equality, 핵심 타입 conformance 테스트가 통과한다.
- Package와 MobileExample의 배포 하한이 모두 iOS 18.0이다.
- README와 CI가 같은 `Scripts/verify` 진입점을 사용한다.
- CI 결과가 실패 시에도 artifact로 보존된다.
- `ROADMAP.md`의 검증 기반 항목에 로컬과 CI 근거가 기록된다.
- 공개 API 이름 변경, 컴포넌트 동작 변경, 신규 컴포넌트가 포함되지 않는다.
