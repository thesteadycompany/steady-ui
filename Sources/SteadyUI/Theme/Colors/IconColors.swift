import SwiftUI

public struct IconColors: Equatable, Sendable {
  public var primary: Color
  public var secondary: Color
  public var tertiary: Color
  public var disabled: Color
  public var inverse: Color
  public var destructive: Color

  public init(
    primary: Color,
    secondary: Color,
    tertiary: Color,
    disabled: Color,
    inverse: Color,
    destructive: Color
  ) {
    self.primary = primary
    self.secondary = secondary
    self.tertiary = tertiary
    self.disabled = disabled
    self.inverse = inverse
    self.destructive = destructive
  }
}
