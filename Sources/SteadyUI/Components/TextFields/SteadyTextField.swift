import SwiftUI

public struct SteadyTextField: View {
  @FocusState private var focused
  @Environment(\.theme) private var theme
  private let text: Binding<String>
  private let placeholder: String
  private let size: SteadyTextFieldSize

  public init(
    text: Binding<String>,
    placeholder: String,
    size: SteadyTextFieldSize = .medium
  ) {
    self.text = text
    self.placeholder = placeholder
    self.size = size
  }

  public var body: some View {
    VStack(spacing: theme.spacing.zero) {
      ZStack(alignment: .topLeading) {
        TextField("", text: text)
          .font(textFont)
          .foregroundStyle(theme.colors.text.primary)
          .focused($focused)
          .padding(contentInsets)

        Text(placeholder)
          .font(textFont)
          .foregroundStyle(
            focused ? theme.colors.text.link : theme.colors.text.disabled
          )
          .scaleEffect(
            isFloating ? floatingPlaceholderScale : 1,
            anchor: .leading
          )
          .offset(y: isFloating ? theme.spacing.zero : restingPlaceholderYOffset)
          .padding(.horizontal, theme.spacing.xSmall)
          .allowsHitTesting(false)
          .animation(.easeInOut(duration: 0.2), value: focused)
          .animation(.easeInOut(duration: 0.2), value: text.wrappedValue)
      }

      Rectangle()
        .fill(focused ? theme.colors.border.focus : theme.colors.border.base)
        .frame(height: underlineHeight)
        .animation(.easeInOut(duration: 0.2), value: focused)
    }
  }

  private var textFont: Font {
    switch size {
    case .small: theme.fonts.body.medium
    case .medium: theme.fonts.body.large
    case .large: theme.fonts.title.small
    }
  }

  private var contentInsets: EdgeInsets {
    switch size {
    case .small:
      .init(
        top: theme.spacing.large,
        leading: theme.spacing.xSmall,
        bottom: theme.spacing.small,
        trailing: theme.spacing.xSmall
      )
    case .medium:
      .init(
        top: theme.spacing.xLarge,
        leading: theme.spacing.xSmall,
        bottom: theme.spacing.small,
        trailing: theme.spacing.xSmall
      )
    case .large:
      .init(
        top: theme.spacing.xLarge + theme.spacing.xSmall,
        leading: theme.spacing.xSmall,
        bottom: theme.spacing.medium,
        trailing: theme.spacing.xSmall
      )
    }
  }

  private var restingPlaceholderYOffset: CGFloat {
    contentInsets.top
  }

  private var floatingPlaceholderScale: CGFloat {
    0.72
  }

  private var underlineHeight: CGFloat {
    focused ? 2 : 1
  }

  private var isFloating: Bool {
    focused || !text.wrappedValue.isEmpty
  }
}
