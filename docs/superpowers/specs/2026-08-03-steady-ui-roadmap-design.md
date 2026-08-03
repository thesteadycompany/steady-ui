# SteadyUI 10주 로드맵 설계

**상태:** 사용자 피드백 반영 후 재검토 대기

**작성일:** 2026-08-03

**대상:** 개발자 1명과 AI 에이전트

**제품 경로:** 사내 앱에서 먼저 검증한 뒤 공개 Swift Package v1.0 출시

## 1. 목표

SteadyUI를 현재의 초기 컴포넌트 모음에서, 사내 제품이 안정적으로 사용할 수 있고 외부 개발자에게 공개할 수 있는 iOS 18 이상용 SwiftUI 라이브러리로 발전시킨다.

10주 뒤에는 다음 조건을 만족해야 한다.

- 공개 API가 명명 규칙과 호환성 정책을 따른다.
- 모든 공개 컴포넌트에 사용 문서, 예제, 접근성 검증, 자동 검증 근거가 있다.
- 표준 디자인 시스템의 핵심 범주인 기반, 액션, 입력, 선택, 콘텐츠, 피드백을 다룬다.
- 사내 앱의 실제 화면에서 릴리스 후보를 검증했다.
- SemVer에 따라 태그를 붙이고 배포할 수 있는 v1.0 릴리스 절차가 있다.
- AI가 저장소 안의 문서만 읽고 다음 작업, 선행 조건, 완료 기준, 검증 명령을 판단할 수 있다.

## 2. 현재 상태와 근거

2026-08-03에 저장소를 정적 분석하고 빌드를 검증했다.

### 구현된 기반

- Swift Package 한 개와 `SteadyUI` 라이브러리 타깃 한 개
- iOS 18 이상, Swift 6 언어 모드
- 의미 기반 색상, 폰트, 간격, 반경 토큰
- `EnvironmentValues.theme`을 통한 테마 주입
- 라이트·다크 모드 적응형 기본 색상
- Button, Badge, Toggle, TextField, Tab, BottomScrollView의 6개 컴포넌트군
- 모든 컴포넌트를 둘러볼 수 있는 iOS 예제 앱

### 검증 결과

- `MobileExample`을 iOS 26.2의 iPhone 17 Pro 시뮬레이터 대상으로 빌드했으며 성공했다.
- 호스트 macOS에서 실행한 `swift test`는 iOS 전용 SwiftUI 소스를 macOS로 컴파일하면서 실패했다. 이 명령은 호스트 진단으로만 사용하고 iOS 릴리스 게이트로 사용하지 않는다.
- 테스트 타깃과 테스트 파일이 없다.
- README, DocC, CONTRIBUTING, CHANGELOG, LICENSE, CI 설정, 릴리스 태그가 없다.
- 공개 API에 `SteadyCTAButonStyle` 오타가 포함되어 있다.
- Reduce Motion과 접근성 레이블 적용이 일부 컴포넌트에만 존재한다.
- 공개 선언에 API 문서 주석이 없다.

### 성숙도 판단

현재 상태는 **기능이 동작하는 초기 알파**다. 토큰과 예제 앱은 좋은 출발점이지만, 컴포넌트를 계속 늘리기 전에 API 규칙과 품질 게이트를 고정해야 한다. v1.0 전이므로 명명과 구조를 바로잡을 비용이 이후보다 낮다.

## 3. 선택한 전략

### 품질 게이트 기반 확장

컴포넌트 수만 빠르게 늘리지 않는다. 각 컴포넌트는 같은 주기에 구현, 문서, 예제, 접근성, 테스트를 완료해야 한다. 게이트를 통과하지 못한 컴포넌트는 로드맵에서 `done`이 될 수 없다.

이 전략을 선택한 이유는 다음과 같다.

- 한 명이 개발하므로 미완성 작업을 여러 개 병렬로 유지하기 어렵다.
- AI는 명시적인 입력과 완료 기준이 있을 때 반복 작업을 안정적으로 수행한다.
- 공개 v1.0 뒤에는 API 변경 비용이 커지므로 기반을 먼저 고정해야 한다.
- 현재 저장소는 작아 2주 안에 품질 기반을 마련할 수 있다.

### 고려했지만 선택하지 않은 전략

- **컴포넌트 확장 우선:** 빠르게 보이지만 테스트와 문서 부채가 누적된다.
- **전면 아키텍처 재설계 우선:** 장기 확장성은 높지만 현재 규모와 10주 목표에는 과하다.

## 4. 범위 원칙

### 포함

- 현재 공개 API와 컴포넌트의 안정화
- 디자인 토큰 검증과 테마 적용 API 정리
- 표준 디자인 시스템에서 자주 쓰이는 핵심 컴포넌트 추가
- 단위, 상태, 시각, 접근성 검증 체계
- README, DocC, 예제 카탈로그, 기여 및 릴리스 문서
- 사내 앱 통합 검증
- 공개 v1.0 준비
- AI용 루트 지침과 구조화된 로드맵

### 제외

- macOS, watchOS, tvOS, visionOS 지원
- UIKit 전용 컴포넌트 API
- 앱 고유 비즈니스 컴포넌트
- 완전한 아이콘 원본 세트 제작
- 자체 내비게이션 프레임워크
- SwiftUI가 이미 충분히 제공하는 컨트롤의 무의미한 래핑
- v1.0 전에 플러그인 또는 코드 생성 시스템 도입

## 5. 공개 API와 구성 원칙

### Swift다운 네이밍

- 공개 이름은 Swift API Design Guidelines의 역할 중심, 사용 지점 중심 원칙을 따른다.
- 렌더링 가능한 공개 컴포넌트 타입은 모듈 최상위에 선언한다. `SteadyUI.Components.Checkbox`, `Component.Checkbox`, `Form.Field`처럼 네임스페이스 또는 다른 타입 안에 중첩하지 않는다.
- SwiftUI와 소비자 앱의 최상위 타입 충돌을 피하기 위해 라이브러리가 소유한 공개 UI 컴포넌트, Style, 컴포넌트 전용 configuration 타입에 `Steady` 접두어를 사용한다. 예를 들어 `SteadyCheckbox`, `SteadyBanner`, `SteadyCTAButtonStyle`로 명명한다.
- SwiftUI의 네이티브 `Button`, `Toggle`, `TextField`, `ProgressView`는 그대로 사용하고 SteadyUI가 제공하는 Style 또는 modifier에만 `Steady` 접두어를 붙인다.
- 타입은 명사 또는 역할 이름, 메서드와 인수 레이블은 호출부가 문장처럼 읽히는 이름을 사용한다.
- `Type`, `Style`, `Size`, `State`, `Variant`처럼 역할이 다른 공개 개념을 이름으로 구분한다. 철자 오류와 축약어 혼용을 허용하지 않는다.
- 렌더링 가능한 컴포넌트가 아닌 전용 configuration 또는 값 타입은 소유 관계가 명백할 때만 중첩할 수 있다.

### v1.0 API 인벤토리와 마이그레이션 계약

| 현재 공개 API | v1.0 API | 호출부 전환 |
| --- | --- | --- |
| `SteadyTheme` | `SteadyTheme` | 변경 없음 |
| `SteadyBadge` | `SteadyBadge` | `type:`을 `role:`로, `style:`을 `emphasis:`로 변경 |
| `SteadyBadgeSize` | `SteadyBadgeSize` | 변경 없음 |
| `SteadyBadgeStyle` | `SteadyBadgeEmphasis` | 타입명과 `emphasis:` 인수 레이블로 변경 |
| `SteadyBadgeType` | `SteadyBadgeRole` | 타입명과 `role:` 인수 레이블로 변경 |
| `SteadyCTAButonStyle` | `SteadyCTAButtonStyle` | 철자를 수정하고 `.cta`를 `.steadyCTA`로 변경 |
| `SteadyButtonType` | `SteadyButtonVariant` | 타입명과 `variant:` 인수 레이블로 변경 |
| `SteadyTextButtonSize` | `SteadyTextButtonSize` | 변경 없음 |
| `SteadyTextButtonStyle` | `SteadyTextButtonStyle` | `.text`를 `.steadyText`로 변경 |
| `SteadyUnderlineTextButtonStyle` | `SteadyUnderlineTextButtonStyle` | `.underline`을 `.steadyUnderline`으로 변경 |
| `SteadyBottomScrollView` | `SteadyBottomScrollView` | 변경 없음 |
| `SteadySwitchTabItem` | `SteadySwitchTabItem` | 변경 없음 |
| `SteadySwitchTab` | `SteadySwitchTab` | 변경 없음 |
| `SteadyTextFieldSize` | `SteadyTextFieldSize` | 변경 없음 |
| `SteadyToggle` | `SteadyToggle` | 기존 `SteadyToggle(isOn:)` 호출 유지 |

현재 저장소에는 릴리스 태그가 없으므로 변경되는 API에 deprecated alias나 호환 wrapper를 제공하지 않는다. Sources와 MobileExample을 같은 변경에서 즉시 전환하며 다음 순서를 지킨다.

1. 새 타입과 인수 레이블을 정의하고 기존 선언을 제거한다.
2. Sources 내부 참조와 static Style factory를 새 이름으로 전환한다.
3. MobileExample의 독립 데모와 유즈케이스를 새 호출부로 전환한다.
4. iOS 전체 테스트와 API 인벤토리 검사를 실행한다.
5. `SteadyBadgeStyle`, `SteadyBadgeType`, `SteadyCTAButonStyle`, `SteadyButtonType`이 남아 있지 않고 각각의 v1.0 대응 타입이 존재하는지 확인한다.

`SteadyToggle`은 이름과 API 형태를 유지한다. track, thumb, press animation, Reduce Motion을 직접 제어해야 하며 SwiftUI `Toggle`과 `ToggleStyle`만으로는 SteadyUI의 외형과 상호작용 계약을 충분히 유지하기 어렵기 때문이다.

### Style 우선 설계

새 UI 요구사항은 아래 순서로 해결한다.

1. 기존 SwiftUI View에 네이티브 Style 프로토콜을 적용한다.
2. Style 프로토콜로 표현할 수 없는 장식이나 횡단 동작은 `ViewModifier`로 제공한다.
3. 고유한 콘텐츠 구조, 레이아웃, 상태 조정이 필요한 경우에만 커스텀 `View`를 만든다.

커스텀 `View`를 선택한 로드맵 항목은 Style 또는 modifier로 해결할 수 없는 이유를 `abstraction_rationale`에 기록해야 한다. 근거가 없으면 구현을 시작할 수 없다.

| 요구사항 | 우선 추상화 | 기준 |
| --- | --- | --- |
| CTA, text, underline 버튼 | `ButtonStyle` | 네이티브 `Button`의 action, role, accessibility 의미를 보존한다. |
| Checkbox, Radio Button | `ToggleStyle` | 네이티브 `Toggle`의 binding과 접근성 의미를 보존한다. |
| SteadyUI 브랜드 토글 | 최상위 `SteadyToggle` View | track, thumb, animation을 직접 제어해야 하므로 Style 우선 규칙의 승인된 예외다. |
| TextField와 SecureField 외형 | `TextFieldStyle` | 네이티브 입력 View의 포커스와 입력 동작을 보존한다. Label, helper, error처럼 Style이 표현할 수 없는 구조만 별도 최상위 View로 조합한다. |
| 선택 가능한 Chip | `ToggleStyle` 또는 `ButtonStyle` | 지속되는 선택 상태면 Toggle, 일회성 action이면 Button을 사용한다. |
| Progress | `ProgressViewStyle` | determinate/indeterminate 의미를 네이티브 `ProgressView`에 유지한다. |
| Skeleton, Card 장식 | `ViewModifier` | 임의의 콘텐츠에 적용할 수 있고 별도 콘텐츠 구조가 필요하지 않다. |
| Badge, Avatar, Banner, Empty State | 최상위 커스텀 `View` | 자체 콘텐츠 구조와 의미가 있어 네이티브 Style만으로 표현되지 않는다. |
| Switch Tab, BottomScrollView | 최상위 커스텀 `View` | 여러 자식의 선택 또는 스크롤 레이아웃을 조정한다. |

Style은 구체 타입도 최상위에 선언하되, 호출부에서는 Swift의 static member lookup을 사용해 `.buttonStyle(.steadyCTA(.primary))`, `.toggleStyle(.steadyCheckbox)`처럼 읽히게 한다. 공개 factory는 `.steadyCTA`, `.steadyText`, `.steadyUnderline`, `.steadyCheckbox`, `.steadyRadio`, `.steadyBox`, `.steadyLine`처럼 `steady` 접두어를 사용한다.

`SteadyToggle`의 `abstraction_rationale`은 “SwiftUI 기본 Toggle의 외형과 애니메이션 커스터마이징 제약 때문에 독립 컴포넌트가 필요하다”로 고정한다. AI는 이 컴포넌트를 `ToggleStyle`로 전환하거나 네이티브 `Toggle`로 대체하지 않는다.

### MobileExample 유즈케이스

`MobileExample`은 단순한 모양 갤러리가 아니라 공개 API의 실행 가능한 사용 설명서다.

- 모든 공개 컴포넌트, Style, modifier에 독립적인 상태·변형 데모를 제공한다.
- 관련 컴포넌트를 실제로 조합한 유즈케이스 화면을 함께 제공한다.
- 루트 내비게이션에서 `Components`와 `Use Cases`를 구분한다.
- v1.0 필수 유즈케이스는 Settings Form, Authentication Form, Content Card 또는 Dashboard, Loading/Error/Empty Feedback Flow다.
- 같은 컴포넌트가 여러 유즈케이스에 쓰일 수 있지만, 공개 API 중 어떤 유즈케이스에도 연결되지 않은 항목은 `done`이 될 수 없다.
- 라이브러리 API를 변경하는 작업은 같은 변경 묶음에서 해당 데모와 유즈케이스를 갱신한다.
- 데모는 앱 전용 우회 스타일을 사용하지 않으며, 소비자가 복사할 수 있는 최소한의 사용 코드로 작성한다.

## 6. 컴포넌트 선정 기준

사내 수요가 아니라 일반적인 디자인 시스템의 필수 범주를 기준으로 한다. 다만 10주 안에 품질을 보장하기 위해 모든 가능한 컴포넌트를 포함하지는 않는다.

우선순위는 아래 순서로 계산한다.

1. 여러 화면에서 반복 사용되는가
2. 기존 토큰과 컴포넌트로 일관되게 표현하기 어려운가
3. 접근성과 상호작용을 중앙에서 올바르게 구현할 가치가 큰가
4. 다른 컴포넌트의 선행 요소인가
5. SwiftUI 기본 API를 단순히 다시 감싸는 수준을 넘어서는가

### v1.0 필수 범주

- **Foundation:** Theme 적용 API, 색상·타이포그래피·간격·반경, 공통 모션
- **Actions:** `SteadyCTAButtonStyle`, `SteadyTextButtonStyle`, `SteadyUnderlineTextButtonStyle`의 상태와 크기 일관성
- **Inputs:** `SteadyBoxTextFieldStyle`, `SteadyLineTextFieldStyle`, `SteadyCheckboxToggleStyle`, `SteadyRadioToggleStyle`
- **Selection:** SteadyToggle, Switch Tab, Chip
- **Content:** Icon 사용 규칙, Divider, Card, Badge, Avatar
- **Feedback:** Progress, Skeleton, Banner, Empty State
- **Layout:** BottomScrollView 유지 및 안정화

### v1.0 이후 후보

- Toast presentation
- Tooltip
- Stepper
- Pagination
- Date/Time 입력
- 고급 Sheet/Dialog 추상화
- 복합 List Row와 Form Section

## 7. 10주 로드맵

일정은 달력상의 약속이 아니라 품질 게이트가 있는 작업 순서다. 한 주의 필수 게이트가 끝나지 않으면 다음 범주의 신규 컴포넌트를 시작하지 않는다.

### 1주차 — 저장소와 API 기준선

**목표:** 이후 모든 변경을 안전하게 검증할 최소 기반을 만든다.

- 현재 공개 API 인벤토리와 v1.0 대응표 작성
- `SteadyCTAButonStyle` 철자 오류를 포함해 기존 최상위 공개 이름과 `Steady` 접두어를 일관된 Swift 이름으로 정리하고 deprecated 호환 API 없이 Sources와 MobileExample을 함께 전환
- 최상위 컴포넌트, Style 우선순위, 명명, 접근 제어, 기본값, 호환성 규칙 정의
- Xcode 26.4.1, Swift 6.3.1, iOS Simulator SDK 26.4, XcodeBuildMCP 2.1.0 검증 환경 고정
- Package와 MobileExample의 배포 하한을 iOS 18.0으로 통일하고 최소 검증 런타임 iOS 18.5의 iPhone 16 Pro 사용
- `./Scripts/verify environment|host|ios --output json` 검증 래퍼 계약과 host/iOS 명령 표준화
- `SteadyUITests` SwiftPM 테스트 타깃과 첫 토큰/API 테스트 추가
- 로컬과 CI에서 동일한 `./Scripts/verify ios --output json` 실행
- 루트 README와 문서 구조 생성

**종료 게이트:** 깨끗한 체크아웃에서 `./Scripts/verify ios --output json`이 성공하고, CI가 같은 명령의 실패를 감지해 병합을 막는다. `swift test`는 macOS 호스트 진단으로만 기록한다.

### 2주차 — 토큰과 컴포넌트 계약

**목표:** 모든 새 컴포넌트가 따를 공통 설계 언어를 고정한다.

- 테마 적용 진입점과 사용자 정의 테마 예제 정리
- 토큰 이름, 값 범위, 의미, 대비 검증
- 상태 모델 정의: normal, pressed, focused, selected, disabled, loading, error
- `Style → ViewModifier → View` 추상화 선택 템플릿, 예외 승인, 근거 기록 규칙 정의
- 크기와 터치 영역 규칙 정의
- 모션 및 Reduce Motion 규칙 정의
- Dynamic Type, VoiceOver, 색상 대비, RTL 검증 매트릭스 정의
- 예제 앱의 `Components`와 `Use Cases` 내비게이션 및 공통 데모 구조 정리

**종료 게이트:** 새 컴포넌트를 만들 때 사용할 API·상태·접근성·예제·테스트 템플릿이 문서와 코드에 존재한다.

### 3주차 — 액션과 단일 선택

**목표:** 기존 액션 계층을 안정화하고 Checkbox를 추가한다.

- CTA, Text, Underline `ButtonStyle`의 크기와 상태 정합성 확보
- 로딩 상태, 최소 터치 영역, Reduce Motion 반영
- Checkbox를 `ToggleStyle`로 구현
- 각 변형의 문서, 독립 데모, Settings Form 유즈케이스, 상태 검증 추가

**종료 게이트:** 액션 컴포넌트와 Checkbox가 모든 필수 상태 및 접근성 매트릭스를 통과한다.

### 4주차 — 입력과 선택 완성

**목표:** 폼 작성에 필요한 최소 입력 집합을 완성한다.

- 기존 Box/Line TextField View를 Steady `TextFieldStyle`로 전환해 네이티브 `TextField`와 `SecureField`에 동일하게 적용
- label, helper, error, disabled 구조는 Style로 표현할 수 없는 부분만 최상위 조합 View로 제공
- Radio Button을 `ToggleStyle`로, Radio Group을 최상위 조합 View로 구현
- 기존 `SteadyToggle(isOn:)` API와 track, thumb, press animation, Reduce Motion 외형을 유지
- `SteadyToggle`의 disabled, VoiceOver, Reduce Motion, Dynamic Type 검증을 보강하고 `ToggleStyle`로 전환하지 않음
- Switch Tab의 접근성 및 Reduce Motion 보강
- 입력 컴포넌트의 포커스, 오류, 키보드 동작 검증
- Authentication Form과 Settings Form 유즈케이스 갱신

**종료 게이트:** 예제 앱에서 접근 가능한 설정 폼 하나를 SteadyUI만으로 구성할 수 있다.

### 5주차 — 콘텐츠 기반

**목표:** 일반 화면을 구성할 저수준 콘텐츠 요소를 제공한다.

- 네이티브 `Image`를 보존하는 Icon 사용 규칙과 API
- Divider modifier
- Card modifier
- 최상위 Avatar View
- 기존 Badge API와 시각 상태 검증
- Content Card 또는 Dashboard 유즈케이스 추가

**종료 게이트:** 목록 또는 대시보드 카드 화면을 앱 전용 스타일 코드 없이 구성할 수 있다.

### 6주차 — 선택 표현과 조합 품질

**목표:** 선택 가능한 콘텐츠와 컴포넌트 조합을 완성한다.

- Chip을 선택 의미에 따라 `ToggleStyle` 또는 `ButtonStyle`로 구현하고 선택, 해제, 비활성 상태 제공
- Switch Tab의 overflow 및 긴 텍스트 정책
- RTL과 큰 Dynamic Type에서 콘텐츠 컴포넌트 검증
- 공통 패딩·애니메이션·상태 계산의 중복 제거
- 3~5주차 컴포넌트의 API 일관성 검토

**종료 게이트:** 공개 API 검토에서 불필요한 중복과 서로 다른 명명 규칙이 남아 있지 않다.

### 7주차 — 피드백

**목표:** 비동기 및 빈 상태를 일관되게 표현한다.

- determinate/indeterminate `ProgressViewStyle`
- Reduce Motion을 따르는 Skeleton modifier
- 최상위 Banner View
- 최상위 Empty State View
- 로딩, 성공, 경고, 오류 예제 시나리오
- Loading/Error/Empty Feedback Flow 유즈케이스 추가

**종료 게이트:** 각 피드백 컴포넌트가 상태 의미를 색상 외의 수단으로도 전달하고 접근성 검증을 통과한다.

### 8주차 — 사내 통합과 API 동결 후보

**목표:** 실제 앱 사용을 통해 설계 가정을 검증한다.

- 사내 앱의 대표 화면 2개 이상에 릴리스 후보 적용
- MobileExample의 모든 공개 API가 하나 이상의 독립 데모와 실제 유즈케이스에 연결되었는지 감사
- 앱 쪽 우회 스타일과 누락된 상태 기록
- API 마찰과 레이아웃 결함 수정
- 성능, 컴파일 시간, 바이너리 영향의 기준선 기록
- v1.0 공개 API 동결 후보 작성

**종료 게이트:** 대표 화면이 앱 전용 우회 구현 없이 동작하고, 남은 공개 API 변경이 명시적으로 기록되어 있다.

### 9주차 — 문서와 릴리스 후보

**목표:** 저장소를 처음 보는 개발자가 독립적으로 도입할 수 있게 한다.

- README 설치 및 빠른 시작 완성
- 모든 공개 API의 DocC 문서 완성
- 컴포넌트별 상태·접근성·테마 예제 완성
- 시각 회귀 기준 이미지 갱신 및 검토
- CONTRIBUTING, CHANGELOG, 지원 정책 작성
- 라이선스는 저장소 소유자가 선택하고 기록한다. 선택이 없으면 공개 릴리스를 차단한다.
- `1.0.0-rc.1` 후보 생성

**종료 게이트:** 새 소비자가 저장소 내부 지식 없이 문서만으로 설치, 테마 적용, 핵심 화면 구성을 완료할 수 있다.

### 10주차 — v1.0 검증과 공개 준비

**목표:** API를 동결하고 재현 가능한 공개 절차를 완성한다.

- 릴리스 후보를 사내 앱에서 최종 검증
- 알려진 P0/P1 결함을 0개로 정리
- 고정된 도구 버전과 iOS 18.5의 iPhone 16 Pro 환경에서 `./Scripts/verify environment --output json` 및 `./Scripts/verify ios --output json` 실행
- 변경 전 API가 남아 있지 않은지 API 인벤토리 검사하고 MobileExample 전체 컴파일 확인
- CI의 JSON 검증 결과를 artifact로 보존
- SemVer, 태그, 릴리스 노트, 마이그레이션 문서 검증
- 패키지 소비자용 새 샘플에서 설치 검증
- 승인 후 `1.0.0` 태그 및 공개 릴리스

**종료 게이트:** 같은 커밋에서 문서화된 명령을 실행하면 모든 검증이 성공하며, 릴리스 체크리스트에 미완료 항목이 없다.

## 8. 공개 UI API 완료 정의

모든 공개 컴포넌트, Style, modifier는 아래 조건을 전부 만족해야 `done`이다.

- 공개 API가 명명 및 호환성 규칙을 따른다.
- 렌더링 가능한 공개 컴포넌트와 Style이 최상위 타입이며 라이브러리 소유 타입에 `Steady` 접두어를 사용한다.
- 네이티브 Style 또는 `ViewModifier`로 해결할 수 있는지 먼저 검토했고, 커스텀 View라면 선택 근거가 로드맵에 있다.
- `SteadyToggle`은 승인된 커스텀 View 예외이며 고정된 `abstraction_rationale`을 유지한다.
- 필수 상태 중 해당되는 상태를 모두 지원한다.
- 테마 토큰만 사용하고 임의 수치를 사용한 경우 근거를 문서화한다.
- Light/Dark, Dynamic Type, VoiceOver, Reduce Motion, disabled, RTL을 검토한다.
- 최소 터치 영역과 색상 대비 기준을 충족한다.
- 단위 또는 상태 테스트가 있다.
- 결정적 시각 검증 또는 승인된 기준 이미지가 있다.
- MobileExample에 모든 공개 변형의 독립 데모가 있다.
- MobileExample의 실제 유즈케이스 하나 이상에서 공개 API를 사용한다.
- 공개 API에 DocC 주석과 사용 예제가 있다.
- 표준 빌드 및 테스트 명령이 성공한다.
- 로드맵 항목에 검증 근거가 연결되어 있다.

## 9. 검증 전략

### 표준 검증 환경

1주차에 생성할 `Scripts/verify`가 다음 값을 단일 진실 공급원으로 관리하고, 실제 환경이 다르면 테스트를 시작하기 전에 실패한다.

| 항목 | 고정 값 | 검사 방법 |
| --- | --- | --- |
| Xcode | 26.4.1 | `xcodebuild -version` |
| Swift | 6.3.1 | `swift --version` |
| iOS Simulator SDK | 26.4 | `xcrun --sdk iphonesimulator --show-sdk-version` |
| XcodeBuildMCP | 2.1.0 | `xcodebuildmcp --version` |
| Package 배포 하한 | iOS 18.0 | `Package.swift`의 `.iOS(.v18)` |
| MobileExample 배포 하한 | iOS 18.0 | Xcode build settings |
| 최소 검증 runtime | iOS 18.5 | `xcodebuildmcp simulator list --output json` |
| 검증 simulator | iPhone 16 Pro | `xcodebuildmcp simulator list --output json` |

### 표준 검증 명령

저장소 래퍼의 인터페이스는 다음 세 명령으로 고정한다.

```bash
./Scripts/verify environment --output json
./Scripts/verify host --output json
./Scripts/verify ios --output json
```

- `environment`는 위 버전과 runtime 및 simulator 존재 여부를 검사한다.
- `host`는 정확히 `swift test`를 실행하고 종료 상태와 로그를 JSON envelope로 반환한다. 이 iOS 전용 패키지는 현재 macOS 컴파일에서 실패하므로 host 결과는 진단용이며 릴리스 게이트가 아니다.
- `ios`는 `environment`가 성공한 뒤 다음 전체 시뮬레이터 테스트를 실행한다. 이 명령이 로컬과 CI의 필수 게이트다.

```bash
xcodebuildmcp simulator test \
  --workspace-path .swiftpm/xcode/package.xcworkspace \
  --scheme SteadyUI \
  --simulator-name "iPhone 16 Pro" \
  --configuration Debug \
  --output json
```

CI도 `./Scripts/verify ios --output json`만 호출해 로컬과 같은 경로를 사용하고 JSON 결과를 artifact로 보존한다. 이 명령은 1주차에 `SteadyUITests` 테스트 타깃과 래퍼를 만든 뒤부터 성공을 요구한다.

### 자동 검증

- Swift 6 컴파일과 엄격한 동시성 검사
- iOS 시뮬레이터 대상 라이브러리 및 예제 앱 빌드
- 토큰, 상태 결정, API 동작의 단위 테스트
- 모든 공개 시각 컴포넌트의 결정적 스냅샷 또는 이미지 기준 비교
- 공개 API 변경 감지
- 문서 빌드와 예제 코드 컴파일
- MobileExample의 컴포넌트 데모와 유즈케이스 내비게이션 컴파일

### 검토 매트릭스

- 밝은 모드와 어두운 모드
- 기본 글자 크기와 접근성 글자 크기
- 활성, 눌림, 선택, 포커스, 비활성, 로딩, 오류 상태
- Reduce Motion 켜짐과 꺼짐
- VoiceOver 레이블, 값, 특성
- LTR과 RTL
- 좁은 iPhone 폭과 iPad 폭
- iOS 18.0 최소 배포 타깃과 iOS 18.5의 iPhone 16 Pro 시뮬레이터 런타임

### 실패 처리

- 검증 실패는 새 컴포넌트보다 우선한다.
- 환경 문제와 제품 결함을 구분해 로드맵 근거에 기록한다.
- 자동화할 수 없는 검토는 담당자, 절차, 결과 이미지를 명시한다.
- P0/P1 결함이 있으면 다음 주차 게이트나 공개 릴리스를 통과할 수 없다.

## 10. AI가 사용할 로드맵 구조

구현 단계에서는 루트에 `ROADMAP.md`와 `AGENTS.md`를 둔다.

### `ROADMAP.md`

사람과 AI가 함께 사용하는 단일 진실 공급원이다. 상단에는 다음 메타데이터를 둔다.

```yaml
roadmap_version: 1
last_updated: 2026-08-04
horizon: 10-weeks
current_phase: foundation
current_focus: SU-001
owner: repository-maintainer
```

모든 작업 항목은 아래 필드를 갖는다.

```yaml
id: SU-001
title: Establish iOS verification entry point
status: ready
priority: P0
phase: foundation
depends_on: []
goal: Make library verification reproducible on a clean checkout.
preferred_abstraction: build-tooling
abstraction_rationale: This item does not render UI.
mobile_example_use_cases: [] # Non-UI work leaves this empty.
acceptance:
  - The pinned verification environment is available.
  - The documented iOS simulator test command succeeds.
  - Local development and CI run the same wrapper command.
verification:
  - ./Scripts/verify environment --output json
  - ./Scripts/verify ios --output json
evidence: []
```

허용 상태는 `planned`, `ready`, `in_progress`, `blocked`, `done`, `deferred`다. `done`은 검증 명령과 결과 또는 리뷰 링크가 `evidence`에 기록된 경우에만 허용한다.

### `AGENTS.md`

AI에게 아래 작업 규칙을 제공한다.

1. 작업 전에 이 설계와 `ROADMAP.md`를 읽는다.
2. `ready`이면서 모든 `depends_on`이 `done`인 가장 높은 우선순위 항목만 선택한다.
3. 동시에 하나의 항목만 `in_progress`로 둔다.
4. 구현 전에 해당 항목의 범위, 공개 API, 테스트를 작은 실행 계획으로 작성한다.
5. UI 항목은 네이티브 Style, `ViewModifier`, 최상위 커스텀 View 순서로 검토하고 `preferred_abstraction`과 `abstraction_rationale`을 기록한다.
6. `SteadyToggle`은 승인된 최상위 커스텀 View로 유지하며 `ToggleStyle`이나 SwiftUI `Toggle`로 전환하지 않는다.
7. 렌더링 가능한 공개 컴포넌트를 다른 타입 또는 네임스페이스 안에 중첩하지 않고 라이브러리 소유 공개 UI 타입에 `Steady` 접두어를 사용한다.
8. 테스트, 최소 구현, 리팩터, 문서, 독립 데모, 실제 유즈케이스 순으로 진행한다.
9. 공개 UI API 완료 정의를 모두 확인한다.
10. 검증 근거 없이 상태를 `done`으로 바꾸지 않는다. UI 항목은 MobileExample의 독립 데모와 실제 유즈케이스 연결도 필요하다.
11. 범위 또는 공개 API 결정이 필요하면 추측하지 않고 항목을 `blocked`로 바꾸고 질문을 기록한다.
12. 우선순위 변경이나 새 컴포넌트 추가 시 결정 기록을 남긴다.

### 로드맵 갱신 규칙

- 작업 시작 시 `ready`에서 `in_progress`로 바꾼다.
- 완료 시 검증 근거와 영향을 받은 파일을 기록한다.
- 주 1회 현재 주차, 실제 완료량, 차단 요소를 검토한다.
- 일정이 밀리면 품질 게이트를 낮추지 않고 v1.0 이후 후보를 먼저 미룬다.
- 이미 공개된 API의 변경은 SemVer 영향과 마이그레이션 방법을 함께 기록한다.
- AI는 날짜만 지났다는 이유로 작업 상태를 바꾸지 않는다.

## 11. 의사결정과 변경 관리

- v1.0 이전에는 명명과 구조 변경을 허용하지만, 사내 소비자 영향과 마이그레이션을 기록한다.
- API 인벤토리에서 변경 대상으로 지정한 이름은 deprecated alias 없이 Sources와 MobileExample을 같은 변경에서 즉시 전환한다.
- 8주차 API 동결 후보 이후의 공개 API 변경은 릴리스 차단 사유로 취급한다.
- 새 외부 의존성은 해결하려는 문제, 대안, 유지보수 위험을 결정 기록에 남긴 뒤 도입한다.
- 커스텀 View를 새로 만들 때는 네이티브 Style과 `ViewModifier`가 부족한 이유를 결정 기록에 남긴다.
- 일정 압박이 생기면 v1.0 이후 후보를 줄인다. 테스트, 접근성, 문서 게이트는 줄이지 않는다.
- 라이선스 선택과 실제 공개 버튼 실행은 저장소 소유자의 승인 사항이다.

## 12. 성공 지표

- `./Scripts/verify environment --output json`과 `./Scripts/verify ios --output json`이 로컬과 CI에서 연속적으로 성공한다.
- v1.0 필수 컴포넌트가 모두 완료 정의를 충족한다.
- 모든 공개 API가 DocC 문서와 예제에 연결된다.
- 모든 공개 UI API가 MobileExample의 독립 데모와 실제 유즈케이스에 연결된다.
- 네이티브 Style 또는 modifier로 표현할 수 있는 기능을 불필요한 커스텀 View로 제공하지 않는다.
- `SteadyToggle`이 승인된 독립 컴포넌트로 유지되고 Settings Form 유즈케이스와 접근성 검증에 연결된다.
- 사내 대표 화면 2개 이상이 SteadyUI 릴리스 후보를 사용한다.
- 알려진 P0/P1 결함이 없다.
- 릴리스 후보 이후 승인되지 않은 공개 API 변경이 없다.
- 처음 참여한 개발자 또는 AI가 `AGENTS.md`와 `ROADMAP.md`만으로 올바른 다음 작업을 선택하고 검증할 수 있다.

## 13. 후속 산출물

이 설계가 최종 승인되면 별도의 구현 계획에서 다음 파일의 정확한 내용과 생성 순서를 정의한다.

- `ROADMAP.md`
- `AGENTS.md`
- `README.md`
- 품질 및 API 규칙 문서
- 테스트 타깃과 CI 설정
- 주차별 컴포넌트 구현 계획
