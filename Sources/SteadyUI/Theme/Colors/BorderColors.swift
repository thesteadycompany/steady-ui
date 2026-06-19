import SwiftUI

public struct BorderColors: Equatable, Sendable {
  public var base: Color
  public var subtle: Color
  public var strong: Color
  public var focus: Color
  public var disabled: Color
  public var destructive: Color

  public init(
    base: Color,
    subtle: Color,
    strong: Color,
    focus: Color,
    disabled: Color,
    destructive: Color
  ) {
    self.base = base
    self.subtle = subtle
    self.strong = strong
    self.focus = focus
    self.disabled = disabled
    self.destructive = destructive
  }
}
