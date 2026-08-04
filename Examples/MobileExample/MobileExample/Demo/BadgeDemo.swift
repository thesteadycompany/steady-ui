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
        SteadyBadge("Info", role: .info)
        SteadyBadge("Success", role: .success, emphasis: .secondary)
        SteadyBadge("Neutral", role: .neutral, emphasis: .secondary)
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
        SteadyBadge("Primary", role: .info, emphasis: .primary)
        SteadyBadge("Secondary", role: .info, emphasis: .secondary)
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
          SteadyBadge("Info", role: .info)
          SteadyBadge("Success", role: .success)
          SteadyBadge("Warning", role: .warning)
          SteadyBadge("Critical", role: .critical)
          SteadyBadge("Neutral", role: .neutral)
        }

        badgeGrid {
          SteadyBadge("Info", role: .info, emphasis: .secondary)
          SteadyBadge("Success", role: .success, emphasis: .secondary)
          SteadyBadge("Warning", role: .warning, emphasis: .secondary)
          SteadyBadge("Critical", role: .critical, emphasis: .secondary)
          SteadyBadge("Neutral", role: .neutral, emphasis: .secondary)
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
