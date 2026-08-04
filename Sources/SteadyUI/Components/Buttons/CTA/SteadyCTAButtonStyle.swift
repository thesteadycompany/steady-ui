import SwiftUI

public struct SteadyCTAButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.theme) private var theme
  private let variant: SteadyButtonVariant

  public init(variant: SteadyButtonVariant) {
    self.variant = variant
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
    switch variant {
    case .primary: theme.colors.action.primary
    case .secondary: theme.colors.action.secondary
    case .destructive: theme.colors.action.destructive
    }
  }

  private var foregroundColor: Color {
    guard isEnabled else {
      return theme.colors.text.disabled
    }
    switch variant {
    case .primary, .destructive:
      return theme.colors.text.inverse
    case .secondary:
      return theme.colors.text.primary
    }
  }
}
