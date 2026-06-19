import Foundation

public struct SteadyTheme: Equatable, Sendable {
  public var colors: ColorTokens

  public init(colors: ColorTokens) {
    self.colors = colors
  }
}
