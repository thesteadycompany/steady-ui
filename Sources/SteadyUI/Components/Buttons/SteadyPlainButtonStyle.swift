import SwiftUI

/// A low-emphasis action appearance without a persistent container.
public struct SteadyPlainButtonStyle: ButtonStyle {
  private let tone: SteadyButtonTone
  private let size: SteadyButtonSize
  private let width: SteadyButtonWidth

  /// Creates a plain button style.
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
        appearance: .plain,
        tone: tone,
        size: size,
        width: width,
        role: configuration.role,
        isPressed: configuration.isPressed
      )
    )
  }
}
