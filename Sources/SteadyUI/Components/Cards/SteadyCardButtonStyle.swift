import SwiftUI

/// A single-target card appearance for a native button or navigation link.
public struct SteadyCardButtonStyle: ButtonStyle {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.isEnabled) private var isEnabled

  /// Creates the default single-target card style.
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .modifier(
        SteadyCardSurfaceModifier(
          isEnabled: isEnabled,
          isPressed: isEnabled && configuration.isPressed
        )
      )
      .scaleEffect(reduceMotion || !configuration.isPressed ? 1 : 0.98)
      .animation(reduceMotion ? nil : stateAnimation, value: configuration.isPressed)
  }

  private var stateAnimation: Animation {
    .interactiveSpring(
      response: 0.22,
      dampingFraction: 0.75,
      blendDuration: 0.1
    )
  }
}

extension ButtonStyle where Self == SteadyCardButtonStyle {
  /// A card surface for one native button or navigation target.
  public static var steadyCard: Self {
    SteadyCardButtonStyle()
  }
}
