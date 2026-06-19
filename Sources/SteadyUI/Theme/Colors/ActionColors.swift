import SwiftUI

public struct ActionColors: Equatable, Sendable {
  public var primary: ActionColor
  public var secondary: ActionColor
  public var destructive: ActionColor

  public init(
    primary: ActionColor,
    secondary: ActionColor,
    destructive: ActionColor
  ) {
    self.primary = primary
    self.secondary = secondary
    self.destructive = destructive
  }
}

public struct ActionColor: Equatable, Sendable {
  public var normal: Color
  public var pressed: Color
  public var disabled: Color

  public init(
    normal: Color,
    pressed: Color,
    disabled: Color
  ) {
    self.normal = normal
    self.pressed = pressed
    self.disabled = disabled
  }
}
