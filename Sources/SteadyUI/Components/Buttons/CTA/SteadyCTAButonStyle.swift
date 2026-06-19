import SwiftUI

public struct SteadyCTAButonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.theme) private var theme
  private let type: SteadyButtonType

  public init(type: SteadyButtonType) {
    self.type = type
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(theme.fonts.title.small)
      .foregroundStyle(foregroundColor)
      .padding(theme.spacing.medium)
      .frame(maxWidth: .infinity)
      .background(
        isEnabled ? (configuration.isPressed ? color.pressed : color.normal) : color.disabled,
        in: .rect(cornerRadius: theme.radius.xLarge)
      )
      .scaleEffect(configuration.isPressed ? 0.98 : 1)
      .animation(
        .interactiveSpring(
          response: 0.22,
          dampingFraction: 0.75,
          blendDuration: 0.1
        ),
        value: configuration.isPressed
      )
  }

  private var color: ActionColor {
    switch type {
    case .primary: theme.colors.action.primary
    case .secondary: theme.colors.action.secondary
    case .destructive: theme.colors.action.destructive
    }
  }

  private var foregroundColor: Color {
    guard isEnabled else {
      return theme.colors.text.disabled
    }
    switch type {
    case .primary, .destructive:
      return theme.colors.text.inverse
    case .secondary:
      return theme.colors.text.primary
    }
  }
}
