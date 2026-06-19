import SwiftUI

public struct BackgroundColors: Equatable, Sendable {
  public var base: Color
  public var subtle: Color
  public var elevated: Color
  public var overlay: Color
  public var inverse: Color

  public init(
    base: Color,
    subtle: Color,
    elevated: Color,
    overlay: Color,
    inverse: Color
  ) {
    self.base = base
    self.subtle = subtle
    self.elevated = elevated
    self.overlay = overlay
    self.inverse = inverse
  }
}
