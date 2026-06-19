import SwiftUI

extension ButtonStyle where Self == SteadyTextButtonStyle {
  public static var text: Self {
    text(.primary)
  }

  public static func text(
    _ type: SteadyButtonType = .primary,
    size: SteadyTextButtonSize = .medium
  ) -> Self {
    SteadyTextButtonStyle(type: type, size: size)
  }
}

extension ButtonStyle where Self == SteadyUnderlineTextButtonStyle {
  public static var underline: Self {
    underline(.primary)
  }

  public static func underline(
    _ type: SteadyButtonType = .primary,
    size: SteadyTextButtonSize = .medium
  ) -> Self {
    SteadyUnderlineTextButtonStyle(type: type, size: size)
  }
}
