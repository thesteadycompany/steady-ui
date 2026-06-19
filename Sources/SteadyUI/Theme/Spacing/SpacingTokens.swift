import Foundation

public struct SpacingTokens: Equatable, Sendable {
  public var zero: CGFloat
  public var xSmall: CGFloat
  public var small: CGFloat
  public var medium: CGFloat
  public var large: CGFloat
  public var xLarge: CGFloat
  public var xxLarge: CGFloat

  public init(
    zero: CGFloat,
    xSmall: CGFloat,
    small: CGFloat,
    medium: CGFloat,
    large: CGFloat,
    xLarge: CGFloat,
    xxLarge: CGFloat
  ) {
    self.zero = zero
    self.xSmall = xSmall
    self.small = small
    self.medium = medium
    self.large = large
    self.xLarge = xLarge
    self.xxLarge = xxLarge
  }
}
