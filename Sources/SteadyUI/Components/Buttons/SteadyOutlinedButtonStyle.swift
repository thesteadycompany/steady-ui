import SwiftUI

/// A medium-emphasis outlined action appearance.
public struct SteadyOutlinedButtonStyle: ButtonStyle {
  private let tone: SteadyButtonTone
  private let size: SteadyButtonSize
  private let width: SteadyButtonWidth

  /// Creates an outlined button style.
  public init(
    tone: SteadyButtonTone = .accent,
    size: SteadyButtonSize = .medium,
    width: SteadyButtonWidth = .fitted
  ) {
    self.tone = tone
    self.size = size
    self.width = width
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label.modifier(
      SteadyActionButtonModifier(
        appearance: .outlined,
        tone: tone,
        size: size,
        width: width,
        role: configuration.role,
        isPressed: configuration.isPressed
      )
    )
  }
}
