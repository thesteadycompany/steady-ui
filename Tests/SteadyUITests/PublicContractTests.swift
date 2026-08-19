import SteadyUI
import SwiftUI
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

  @Test("button styles separate appearance, tone, size, width, and role")
  @MainActor
  func buttonStylesSeparateAppearanceToneSizeWidthAndRole() {
    let tone: SteadyButtonTone = .accent
    let size: SteadyButtonSize = .small
    let width: SteadyButtonWidth = .expanded
    let filled: SteadyFilledButtonStyle = .steadyFilled(
      tone: tone,
      size: size,
      width: width
    )
    let outlined: SteadyOutlinedButtonStyle = .steadyOutlined(tone: .neutral)
    let plain: SteadyPlainButtonStyle = .steadyPlain(size: .large)

    requireEquatableAndSendable(SteadyButtonTone.self)
    requireEquatableAndSendable(SteadyButtonSize.self)
    requireEquatableAndSendable(SteadyButtonWidth.self)
    _ = SteadyFilledButtonStyle(tone: tone, size: size, width: width)
    _ = SteadyOutlinedButtonStyle(tone: .neutral)
    _ = SteadyPlainButtonStyle()
    _ = Button("Delete", role: .destructive) {}
      .buttonStyle(filled)
    _ = outlined
    _ = plain
  }

  @Test("list rows and cards compose with native controls")
  @MainActor
  func listRowsAndCardsComposeWithNativeControls() {
    let row = SteadyListRow(
      leading: { Image(systemName: "person") },
      content: { Text("Account") },
      supporting: { Text("Steady Team") },
      trailing: { Image(systemName: "chevron.right") }
    )
    let rowStyle: SteadyListRowButtonStyle = .steadyListRow
    let cardStyle: SteadyCardButtonStyle = .steadyCard

    _ = Button(action: {}, label: { row })
      .buttonStyle(rowStyle)
    _ = NavigationLink(destination: { Text("Detail") }, label: { row })
    _ = Toggle(isOn: .constant(true), label: { row })
    _ = Text("Static card").steadyCard()
    _ = Button("Interactive card") {}
      .buttonStyle(cardStyle)
    _ = NavigationLink(destination: { Text("Detail") }) {
      Text("Navigating card")
    }
    .buttonStyle(cardStyle)
  }

  private func requireEquatableAndSendable<Value: Equatable & Sendable>(
    _: Value.Type
  ) {}
}
