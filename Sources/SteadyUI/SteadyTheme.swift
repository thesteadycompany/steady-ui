import Foundation

public struct SteadyTheme: Equatable, Sendable {
  public var colors: ColorTokens
  public var fonts: FontTokens
  public var radius: RadiusTokens
  public var spacing: SpacingTokens

  public init(
    colors: ColorTokens,
    fonts: FontTokens,
    radius: RadiusTokens,
    spacing: SpacingTokens
  ) {
    self.colors = colors
    self.fonts = fonts
    self.radius = radius
    self.spacing = spacing
  }
}
