import SwiftUI

/// A noninteractive list-row layout with semantic leading and trailing slots.
public struct SteadyListRow<
  Leading: View,
  Content: View,
  Supporting: View,
  Trailing: View
>: View {
  @Environment(\.theme) private var theme

  private let leading: Leading
  private let content: Content
  private let supporting: Supporting
  private let trailing: Trailing

  /// Creates a row with all four semantic content slots.
  public init(
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder content: () -> Content,
    @ViewBuilder supporting: () -> Supporting,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.leading = leading()
    self.content = content()
    self.supporting = supporting()
    self.trailing = trailing()
  }

  public var body: some View {
    HStack(spacing: theme.spacing.medium) {
      leading

      VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
        content
          .font(theme.fonts.body.large)

        supporting
          .font(theme.fonts.body.medium)
          .foregroundStyle(theme.colors.text.secondary)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      trailing
    }
    .padding(.vertical, theme.spacing.small)
    .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
    .contentShape(.rect)
  }
}

extension SteadyListRow
where Leading == EmptyView, Supporting == EmptyView, Trailing == EmptyView {
  /// Creates a row containing only primary content.
  public init(@ViewBuilder content: () -> Content) {
    self.init(
      leading: { EmptyView() },
      content: content,
      supporting: { EmptyView() },
      trailing: { EmptyView() }
    )
  }
}

extension SteadyListRow where Leading == EmptyView, Supporting == EmptyView {
  /// Creates a row with primary and trailing content.
  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.init(
      leading: { EmptyView() },
      content: content,
      supporting: { EmptyView() },
      trailing: trailing
    )
  }
}

extension SteadyListRow where Leading == EmptyView, Trailing == EmptyView {
  /// Creates a row with primary and supporting content.
  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder supporting: () -> Supporting
  ) {
    self.init(
      leading: { EmptyView() },
      content: content,
      supporting: supporting,
      trailing: { EmptyView() }
    )
  }
}

extension SteadyListRow where Supporting == EmptyView {
  /// Creates a row with leading, primary, and trailing content.
  public init(
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder content: () -> Content,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.init(
      leading: leading,
      content: content,
      supporting: { EmptyView() },
      trailing: trailing
    )
  }
}
