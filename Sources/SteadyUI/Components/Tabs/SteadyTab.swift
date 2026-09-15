import SwiftUI

public protocol SteadyTabItem: Equatable, Identifiable, Sendable {
  var title: String { get }
}

public struct SteadyTab<Item: SteadyTabItem>: View {
  @Environment(\.theme) private var theme
  private let animationResponse: Double = 0.3
  private let animationDamping: Double = 0.7
  private let animationID = "steady-tab-item-id"
  @Namespace private var animation
  private let items: [Item]
  private let current: Item
  private let action: (Item) -> Void

  public init(
    items: [Item],
    current: Item,
    action: @escaping (Item) -> Void
  ) {
    self.items = items
    self.current = current
    self.action = action
  }

  public var body: some View {
    HStack(spacing: theme.spacing.small) {
      ForEach(items) { item in
        toggleItem(item: item)
      }
    }
    .padding(theme.spacing.xSmall)
  }

  private func toggleItem(item: Item) -> some View {
    Button {
      withAnimation(
        .spring(
          response: animationResponse,
          dampingFraction: animationDamping
        )
      ) {
        action(item)
      }
    } label: {
      Text(item.title)
        .font(
          item == current ? theme.fonts.body.large.bold() : theme.fonts.body.large
        )
        .foregroundStyle(
          item == current ? theme.colors.text.primary : theme.colors.text.secondary
        )
        .padding(.vertical, theme.spacing.small)
        .padding(.horizontal, theme.spacing.xSmall)
        .background(alignment: .bottom) {
          if item == current {
            Capsule()
              .frame(height: 2)
              .foregroundStyle(theme.colors.text.primary)
              .matchedGeometryEffect(id: animationID, in: animation)
          }
        }
    }
    .buttonStyle(SteadyTabButtonStyle())
  }
}

private struct SteadyTabButtonStyle: ButtonStyle {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.isEnabled) var isEnabled

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.96 : 1)
      .animation(animation, value: configuration.isPressed)
      .opacity(isEnabled ? 1 : 0.7)
  }

  private var animation: Animation {
    reduceMotion ? .easeOut(duration: 0.12) : .interactiveSpring(
      response: 0.24,
      dampingFraction: 0.78,
      blendDuration: 0.1
    )
  }
}
