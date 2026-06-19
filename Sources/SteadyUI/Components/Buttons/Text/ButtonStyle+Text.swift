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
