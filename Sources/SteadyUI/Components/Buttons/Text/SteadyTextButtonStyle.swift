import SwiftUI

public struct SteadyTextButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.theme) private var theme
  private let type: SteadyButtonType
  private let size: SteadyTextButtonSize

  public init(
    type: SteadyButtonType = .primary,
    size: SteadyTextButtonSize = .medium
  ) {
    self.type = type
    self.size = size
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(font)
      .foregroundStyle(foregroundColor(isPressed: configuration.isPressed))
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .contentShape(.rect)
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(
        .interactiveSpring(
          response: 0.22,
          dampingFraction: 0.75,
          blendDuration: 0.1
        ),
        value: configuration.isPressed
      )
  }

  private var font: Font {
    switch size {
    case .small:
      theme.fonts.label.small
    case .medium:
      theme.fonts.label.medium
    case .large:
      theme.fonts.label.large
    }
  }

  private var horizontalPadding: CGFloat {
    switch size {
    case .small:
      theme.spacing.small
    case .medium:
      theme.spacing.medium
    case .large:
      theme.spacing.large
    }
  }

  private var verticalPadding: CGFloat {
    switch size {
    case .small:
      theme.spacing.xSmall
    case .medium:
      theme.spacing.small
    case .large:
      theme.spacing.medium
    }
  }

  private func foregroundColor(isPressed: Bool) -> Color {
    guard isEnabled else {
      return theme.colors.text.disabled
    }

    switch type {
    case .primary:
      return isPressed ? theme.colors.action.primary.pressed : theme.colors.action.primary.normal
    case .secondary:
      return isPressed ? theme.colors.text.primary : theme.colors.text.secondary
    case .destructive:
      return isPressed ? theme.colors.action.destructive.pressed : theme.colors.text.destructive
    }
  }
}
