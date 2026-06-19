import Foundation

public struct SteadyTheme: Equatable, Sendable {
  public var colors: ColorTokens
  public var fonts: FontTokens

  public init(
    colors: ColorTokens,
    fonts: FontTokens
  ) {
    self.colors = colors
    self.fonts = fonts
  }
}
