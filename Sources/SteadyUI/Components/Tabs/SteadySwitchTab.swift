import SwiftUI

public protocol SteadySwitchTabItem: Equatable, Identifiable, Sendable {
  var title: String { get }
}

public struct SteadySwitchTab<Item: SteadySwitchTabItem>: View {
  @Environment(\.theme) private var theme
  private let animationResponse: Double = 0.3
  private let animationDamping: Double = 0.7
  private let animationID = "steady-switch-tab-item-id"

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
    HStack(spacing: theme.spacing.zero) {
      ForEach(items) { item in
        toggleItem(item: item)
      }
    }
    .padding(theme.spacing.xSmall)
    .background {
      RoundedRectangle(cornerRadius: theme.radius.medium)
        .fill(theme.colors.background.elevated)
    }
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
        .font(theme.fonts.body.large)
        .foregroundStyle(theme.colors.text.primary)
        .padding(.vertical, theme.spacing.xSmall)
        .padding(.horizontal, theme.spacing.small)
        .background {
          if item == current {
            RoundedRectangle(cornerRadius: theme.radius.medium)
              .foregroundStyle(theme.colors.background.base)
              .matchedGeometryEffect(id: animationID, in: animation)
          }
        }
    }
    .buttonStyle(SteadySwitchTabButtonStyle())
  }
}

private struct SteadySwitchTabButtonStyle: ButtonStyle {
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
