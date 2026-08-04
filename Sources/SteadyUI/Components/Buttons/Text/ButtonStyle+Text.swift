import SwiftUI

extension ButtonStyle where Self == SteadyTextButtonStyle {
  public static var steadyText: Self {
    steadyText(.primary)
  }

  public static func steadyText(
    _ variant: SteadyButtonVariant = .primary,
    size: SteadyTextButtonSize = .medium
  ) -> Self {
    SteadyTextButtonStyle(variant: variant, size: size)
  }
}

extension ButtonStyle where Self == SteadyUnderlineTextButtonStyle {
  public static var steadyUnderline: Self {
    steadyUnderline(.primary)
  }

  public static func steadyUnderline(
    _ variant: SteadyButtonVariant = .primary,
    size: SteadyTextButtonSize = .medium
  ) -> Self {
    SteadyUnderlineTextButtonStyle(variant: variant, size: size)
  }
}
