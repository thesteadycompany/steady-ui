import Foundation

public struct ColorTokens: Equatable, Sendable {
  public var action: ActionColors
  public var background: BackgroundColors
  public var border: BorderColors
  public var icon: IconColors
  public var status: StatusColors
  public var text: TextColors

  public init(
    action: ActionColors,
    background: BackgroundColors,
    border: BorderColors,
    icon: IconColors,
    status: StatusColors,
    text: TextColors
  ) {
    self.action = action
    self.background = background
    self.border = border
    self.icon = icon
    self.status = status
    self.text = text
  }
}
