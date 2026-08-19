import SwiftUI

extension ButtonStyle where Self == SteadyFilledButtonStyle {
  /// The default accent, medium, fitted filled style.
  public static var steadyFilled: Self {
    SteadyFilledButtonStyle()
  }

  /// Creates a filled style with independent color, size, and width axes.
  public static func steadyFilled(
    tone: SteadyButtonTone = .accent,
    size: SteadyButtonSize = .medium,
    width: SteadyButtonWidth = .fitted
  ) -> Self {
    SteadyFilledButtonStyle(tone: tone, size: size, width: width)
  }
}

extension ButtonStyle where Self == SteadyOutlinedButtonStyle {
  /// The default accent, medium, fitted outlined style.
  public static var steadyOutlined: Self {
    SteadyOutlinedButtonStyle()
  }

  /// Creates an outlined style with independent color, size, and width axes.
  public static func steadyOutlined(
    tone: SteadyButtonTone = .accent,
    size: SteadyButtonSize = .medium,
    width: SteadyButtonWidth = .fitted
  ) -> Self {
    SteadyOutlinedButtonStyle(tone: tone, size: size, width: width)
  }
}

extension ButtonStyle where Self == SteadyPlainButtonStyle {
  /// The default accent, medium, fitted plain style.
  public static var steadyPlain: Self {
    SteadyPlainButtonStyle()
  }

  /// Creates a plain style with independent color, size, and width axes.
  public static func steadyPlain(
    tone: SteadyButtonTone = .accent,
    size: SteadyButtonSize = .medium,
    width: SteadyButtonWidth = .fitted
  ) -> Self {
    SteadyPlainButtonStyle(tone: tone, size: size, width: width)
  }
}
