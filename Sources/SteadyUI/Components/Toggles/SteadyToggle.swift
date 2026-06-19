import SwiftUI

public struct SteadyToggle: View {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.theme) private var theme
  private let isOn: Binding<Bool>

  public init(isOn: Binding<Bool>) {
    self.isOn = isOn
  }

  public var body: some View {
    Button(action: toggleTapped) {
      ZStack(alignment: isOn.wrappedValue ? .trailing : .leading) {
        Capsule()
          .fill(trackColor)

        Circle()
          .fill(thumbColor)
          .frame(width: thumbDiameter, height: thumbDiameter)
          .padding(.horizontal, thumbInset)
          .shadow(
            color: thumbShadowColor,
            radius: thumbShadowRadius,
            x: theme.spacing.zero,
            y: 1
          )
      }
      .frame(width: trackWidth, height: trackHeight)
      .contentShape(.rect)
      .animation(stateAnimation, value: isOn.wrappedValue)
    }
    .buttonStyle(SteadyToggleButtonStyle(animation: stateAnimation))
    .accessibilityLabel("Toggle")
    .accessibilityValue(isOn.wrappedValue ? "On" : "Off")
  }

  private func toggleTapped() {
    withAnimation(stateAnimation) {
      isOn.wrappedValue.toggle()
    }
  }

  private var trackWidth: CGFloat {
    theme.spacing.xxLarge + theme.spacing.xLarge
  }

  private var trackHeight: CGFloat {
    theme.spacing.xLarge + theme.spacing.small
  }

  private var thumbInset: CGFloat {
    theme.spacing.xSmall
  }

  private var thumbDiameter: CGFloat {
    trackHeight - thumbInset * 2
  }

  private var trackColor: Color {
    isOn.wrappedValue ? theme.colors.action.primary.normal : theme.colors.action.secondary.normal
  }

  private var thumbColor: Color {
    .white
  }

  private var thumbShadowColor: Color {
    .black.opacity(0.16)
  }

  private var thumbShadowRadius: CGFloat {
    2
  }

  private var stateAnimation: Animation {
    reduceMotion ? .easeOut(duration: 0.12) : .interactiveSpring(
      response: 0.24,
      dampingFraction: 0.78,
      blendDuration: 0.1
    )
  }
}

private struct SteadyToggleButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  let animation: Animation

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.96 : 1)
      .animation(animation, value: configuration.isPressed)
      .opacity(isEnabled ? 1 : 0.7)
  }
}
