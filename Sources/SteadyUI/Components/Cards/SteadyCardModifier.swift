import SwiftUI

/// A static card decoration that can contain independently interactive content.
public struct SteadyCardModifier: ViewModifier {
  /// Creates the default static card decoration.
  public init() {}

  public func body(content: Content) -> some View {
    content.modifier(
      SteadyCardSurfaceModifier(isEnabled: true, isPressed: false)
    )
  }
}

extension View {
  /// Groups this view in a static card that may contain independent controls.
  public func steadyCard() -> some View {
    modifier(SteadyCardModifier())
  }
}
