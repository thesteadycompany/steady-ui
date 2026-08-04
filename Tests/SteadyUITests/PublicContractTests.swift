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
