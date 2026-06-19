import Foundation

public struct RadiusTokens: Equatable, Sendable {
  public var zero: CGFloat
  public var small: CGFloat
  public var medium: CGFloat
  public var large: CGFloat
  public var xLarge: CGFloat

  public init(
    zero: CGFloat,
    small: CGFloat,
    medium: CGFloat,
    large: CGFloat,
    xLarge: CGFloat
  ) {
    self.zero = zero
    self.small = small
    self.medium = medium
    self.large = large
    self.xLarge = xLarge
  }
}
