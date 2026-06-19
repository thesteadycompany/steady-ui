import SteadyUI
import SwiftUI

struct BadgeDemo: View {
  @Environment(\.theme) private var theme

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        header
        stylesSection
        sizesSection
        colorsSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Badges")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("Steady Badge")
        .font(theme.fonts.display.small)
        .foregroundStyle(theme.colors.text.primary)

      Text("Semantic status labels with primary and secondary emphasis.")
        .font(theme.fonts.body.large)
        .foregroundStyle(theme.colors.text.secondary)

      badgeGrid {
        SteadyBadge("Info", type: .info)
        SteadyBadge("Success", type: .success, style: .secondary)
        SteadyBadge("Neutral", type: .neutral, style: .secondary)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(theme.spacing.xLarge)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private var stylesSection: some View {
    demoSection("Styles") {
      badgeGrid {
        SteadyBadge("Primary", type: .info, style: .primary)
        SteadyBadge("Secondary", type: .info, style: .secondary)
      }
    }
  }

  private var sizesSection: some View {
    demoSection("Sizes") {
      badgeGrid {
        SteadyBadge("XSmall", size: .xSmall)
        SteadyBadge("Small", size: .small)
        SteadyBadge("Medium", size: .medium)
        SteadyBadge("Large", size: .large)
      }
    }
  }

  private var colorsSection: some View {
    demoSection("Semantic Colors") {
      VStack(alignment: .leading, spacing: theme.spacing.medium) {
        badgeGrid {
          SteadyBadge("Info", type: .info)
          SteadyBadge("Success", type: .success)
          SteadyBadge("Warning", type: .warning)
          SteadyBadge("Critical", type: .critical)
          SteadyBadge("Neutral", type: .neutral)
        }

        badgeGrid {
          SteadyBadge("Info", type: .info, style: .secondary)
          SteadyBadge("Success", type: .success, style: .secondary)
          SteadyBadge("Warning", type: .warning, style: .secondary)
          SteadyBadge("Critical", type: .critical, style: .secondary)
          SteadyBadge("Neutral", type: .neutral, style: .secondary)
        }
      }
    }
  }

  private func demoSection<Content: View>(
    _ title: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(title)
        .font(theme.fonts.title.small)
        .foregroundStyle(theme.colors.text.primary)

      content()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private func badgeGrid<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    LazyVGrid(
      columns: [GridItem(.adaptive(minimum: 96), spacing: theme.spacing.small)],
      alignment: .leading,
      spacing: theme.spacing.small
    ) {
      content()
    }
    .padding(theme.spacing.large)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }
}
