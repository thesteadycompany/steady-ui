import SwiftUI

enum SteadyButtonAppearance {
  case filled
  case outlined
  case plain
}

struct SteadyActionButtonModifier: ViewModifier {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.theme) private var theme

  let appearance: SteadyButtonAppearance
  let tone: SteadyButtonTone
  let size: SteadyButtonSize
  let width: SteadyButtonWidth
  let role: ButtonRole?
  let isPressed: Bool

  func body(content: Content) -> some View {
    content
      .font(font)
      .foregroundStyle(foregroundColor)
      .padding(.horizontal, horizontalPadding)
      .frame(minWidth: 44, minHeight: 44)
      .frame(maxWidth: width == .expanded ? .infinity : nil)
      .background(backgroundColor, in: shape)
      .overlay {
        shape
          .stroke(borderColor, lineWidth: appearance == .outlined ? 1 : 0)
      }
      .contentShape(shape)
      .scaleEffect(reduceMotion || !isPressed ? 1 : 0.98)
      .animation(reduceMotion ? nil : stateAnimation, value: isPressed)
  }

  private var shape: RoundedRectangle {
    .rect(cornerRadius: theme.radius.xLarge)
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
      theme.spacing.medium
    case .medium:
      theme.spacing.large
    case .large:
      theme.spacing.xLarge
    }
  }

  private var foregroundColor: Color {
    guard isEnabled else { return theme.colors.text.disabled }

    switch appearance {
    case .filled:
      return theme.colors.text.inverse
    case .outlined, .plain:
      return isPressed ? actionColor.pressed : actionColor.normal
    }
  }

  private var backgroundColor: Color {
    switch appearance {
    case .filled:
      guard isEnabled else { return actionColor.disabled }
      return isPressed ? actionColor.pressed : actionColor.normal
    case .outlined, .plain:
      guard isEnabled, isPressed else { return .clear }
      return actionColor.normal.opacity(0.1)
    }
  }

  private var borderColor: Color {
    guard appearance == .outlined else { return .clear }
    guard isEnabled else { return theme.colors.border.disabled }
    return actionColor.normal
  }

  private var actionColor: ActionColor {
    if role == .destructive {
      return theme.colors.action.destructive
    }
    if role == .cancel {
      return theme.colors.action.neutral
    }
    switch tone {
    case .accent:
      return theme.colors.action.primary
    case .neutral:
      return theme.colors.action.neutral
    }
  }

  private var stateAnimation: Animation {
    .interactiveSpring(
      response: 0.22,
      dampingFraction: 0.75,
      blendDuration: 0.1
    )
  }
}
