import SwiftUI

public struct SteadyBadge: View {
  @Environment(\.theme) private var theme
  private let title: String
  private let type: SteadyBadgeType
  private let style: SteadyBadgeStyle
  private let size: SteadyBadgeSize

  public init(
    _ title: String,
    type: SteadyBadgeType = .info,
    style: SteadyBadgeStyle = .primary,
    size: SteadyBadgeSize = .medium
  ) {
    self.title = title
    self.type = type
    self.style = style
    self.size = size
  }

  public var body: some View {
    Text(title)
      .font(font)
      .foregroundStyle(foregroundColor)
      .lineLimit(1)
      .minimumScaleFactor(0.75)
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .background(backgroundColor, in: .rect(cornerRadius: cornerRadius))
      .overlay {
        if style == .secondary {
          RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .stroke(borderColor)
        }
      }
  }

  private var statusColor: StatusColor {
    switch type {
    case .info:
      theme.colors.status.info
    case .success:
      theme.colors.status.success
    case .warning:
      theme.colors.status.warning
    case .critical:
      theme.colors.status.critical
    case .neutral:
      .init(
        background: theme.colors.background.subtle,
        foreground: theme.colors.text.secondary,
        border: theme.colors.border.subtle
      )
    }
  }

  private var font: Font {
    switch size {
    case .xSmall, .small:
      theme.fonts.label.small
    case .medium:
      theme.fonts.label.medium
    case .large:
      theme.fonts.label.large
    }
  }

  private var horizontalPadding: CGFloat {
    switch size {
    case .xSmall:
      theme.spacing.xSmall
    case .small:
      theme.spacing.small
    case .medium:
      theme.spacing.medium
    case .large:
      theme.spacing.large
    }
  }

  private var verticalPadding: CGFloat {
    switch size {
    case .xSmall:
      2
    case .small:
      theme.spacing.xSmall
    case .medium:
      theme.spacing.xSmall + 2
    case .large:
      theme.spacing.small
    }
  }

  private var cornerRadius: CGFloat {
    switch size {
    case .xSmall, .small:
      theme.radius.small
    case .medium:
      theme.radius.medium
    case .large:
      theme.radius.large
    }
  }

  private var foregroundColor: Color {
    switch style {
    case .primary:
      theme.colors.text.inverse
    case .secondary:
      statusColor.foreground
    }
  }

  private var backgroundColor: Color {
    switch style {
    case .primary:
      statusColor.foreground
    case .secondary:
      statusColor.background
    }
  }

  private var borderColor: Color {
    statusColor.border
  }
}
