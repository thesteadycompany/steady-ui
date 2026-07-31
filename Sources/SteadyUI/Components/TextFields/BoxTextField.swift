import SwiftUI

public struct BoxTextField: View {
  @FocusState private var focused
  @Environment(\.theme) private var theme
  private let text: Binding<String>
  private let label: String?
  private let placeholder: String
  private let size: SteadyTextFieldSize

  public init(
    text: Binding<String>,
    label: String? = nil,
    placeholder: String,
    size: SteadyTextFieldSize = .medium
  ) {
    self.text = text
    self.label = label
    self.placeholder = placeholder
    self.size = size
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: labelSpacing) {
      if let label {
        Text(label)
          .font(labelFont)
          .foregroundStyle(focused ? theme.colors.border.focus : theme.colors.text.secondary)
          .padding(.leading, labelLeadingPadding)
      }

      TextField(
        placeholder,
        text: text,
        prompt: Text(placeholder)
          .font(textFont)
          .foregroundStyle(theme.colors.text.disabled)
      )
      .font(textFont)
      .foregroundStyle(theme.colors.text.primary)
      .focused($focused)
      .padding(contentInsets)
      .background(
        theme.colors.background.subtle,
        in: .rect(cornerRadius: radius)
      )
      .overlay {
        RoundedRectangle(cornerRadius: radius)
          .stroke(
            focused ? theme.colors.border.focus : theme.colors.border.base,
            lineWidth: 1
          )
      }
    }
  }

  private var textFont: Font {
    switch size {
    case .small: theme.fonts.body.medium
    case .medium: theme.fonts.body.large
    case .large: theme.fonts.title.small
    }
  }

  private var radius: CGFloat {
    switch size {
    case .small: theme.radius.medium
    case .medium: theme.radius.large
    case .large: theme.radius.xLarge
    }
  }

  private var labelFont: Font {
    switch size {
    case .small: theme.fonts.body.small
    case .medium: theme.fonts.body.medium
    case .large: theme.fonts.body.large
    }
  }

  private var labelSpacing: CGFloat {
    switch size {
    case .small: theme.spacing.xSmall
    case .medium: theme.spacing.small
    case .large: theme.spacing.small
    }
  }

  private var labelLeadingPadding: CGFloat {
    switch size {
    case .small: theme.spacing.xSmall
    case .medium: theme.spacing.small
    case .large: theme.spacing.small
    }
  }

  private var contentInsets: EdgeInsets {
    switch size {
    case .small:
        .init(
          top: theme.spacing.xSmall,
          leading: theme.spacing.small,
          bottom: theme.spacing.xSmall,
          trailing: theme.spacing.small
        )
    case .medium:
        .init(
          top: theme.spacing.small,
          leading: theme.spacing.medium,
          bottom: theme.spacing.small,
          trailing: theme.spacing.medium
        )
    case .large:
        .init(
          top: theme.spacing.medium,
          leading: theme.spacing.large,
          bottom: theme.spacing.medium,
          trailing: theme.spacing.large
        )
    }
  }
}
