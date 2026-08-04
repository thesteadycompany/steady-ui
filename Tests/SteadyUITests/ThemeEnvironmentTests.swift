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
