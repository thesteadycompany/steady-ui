import SwiftUI

struct SteadyCardSurfaceModifier: ViewModifier {
  @Environment(\.theme) private var theme

  let isEnabled: Bool
  let isPressed: Bool

  func body(content: Content) -> some View {
    content
      .padding(theme.spacing.large)
      .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
      .background(backgroundColor, in: shape)
      .overlay {
        shape.stroke(theme.colors.border.subtle, lineWidth: 1)
      }
      .contentShape(shape)
      .opacity(isEnabled ? 1 : 0.45)
  }

  private var shape: RoundedRectangle {
    .rect(cornerRadius: theme.radius.large)
  }

  private var backgroundColor: Color {
    isPressed ? theme.colors.background.elevated : theme.colors.background.subtle
  }
}
