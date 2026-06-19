import SwiftUI

public struct StatusColors: Equatable, Sendable {
  public var info: StatusColor
  public var success: StatusColor
  public var warning: StatusColor
  public var critical: StatusColor

  public init(
    info: StatusColor,
    success: StatusColor,
    warning: StatusColor,
    critical: StatusColor
  ) {
    self.info = info
    self.success = success
    self.warning = warning
    self.critical = critical
  }
}

public struct StatusColor: Equatable, Sendable {
  public var background: Color
  public var foreground: Color
  public var border: Color

  public init(
    background: Color,
    foreground: Color,
    border: Color
  ) {
    self.background = background
    self.foreground = foreground
    self.border = border
  }
}
