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

  private func requireEquatableAndSendable<Value: Equatable & Sendable>(
    _: Value.Type
  ) {}
}
