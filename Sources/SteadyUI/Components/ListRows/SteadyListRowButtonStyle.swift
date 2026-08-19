import SwiftUI

/// Press and disabled feedback for a button whose label is a list row.
public struct SteadyListRowButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.theme) private var theme

  /// Creates list-row press and disabled feedback.
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        isEnabled && configuration.isPressed
          ? theme.colors.background.elevated
          : .clear
      )
      .contentShape(.rect)
      .opacity(isEnabled ? 1 : 0.45)
  }
}

extension ButtonStyle where Self == SteadyListRowButtonStyle {
  /// Press and disabled feedback for a button labeled with `SteadyListRow`.
  public static var steadyListRow: Self {
    SteadyListRowButtonStyle()
  }
}
