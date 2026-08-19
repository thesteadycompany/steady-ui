import SteadyUI
import SwiftUI

/// Coordinates the comparison layout and action state, which a Style or ViewModifier cannot provide.
struct ActionButtonDemo: View {
  @Environment(\.theme) private var theme
  @State private var lastSelection = "None"

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        Text("Last action: \(lastSelection)")
          .font(theme.fonts.body.large)
          .foregroundStyle(theme.colors.text.secondary)
          .steadyCard()

        demoSection("Appearance") {
          VStack(spacing: theme.spacing.medium) {
            Button("Filled") { lastSelection = "Filled" }
              .buttonStyle(.steadyFilled(width: .expanded))

            Button("Outlined") { lastSelection = "Outlined" }
              .buttonStyle(.steadyOutlined(width: .expanded))

            Button("Plain") { lastSelection = "Plain" }
              .buttonStyle(.steadyPlain)
          }
        }

        demoSection("Tone and role") {
          VStack(spacing: theme.spacing.medium) {
            Button("Neutral") { lastSelection = "Neutral" }
              .buttonStyle(.steadyFilled(tone: .neutral, width: .expanded))

            Button("Delete", role: .destructive) { lastSelection = "Delete" }
              .buttonStyle(.steadyOutlined(width: .expanded))

            Button("Cancel", role: .cancel) { lastSelection = "Cancel" }
              .buttonStyle(.steadyPlain)
          }
        }

        demoSection("Size") {
          HStack(spacing: theme.spacing.small) {
            Button("Small") { lastSelection = "Small" }
              .buttonStyle(.steadyOutlined(size: .small))

            Button("Medium") { lastSelection = "Medium" }
              .buttonStyle(.steadyOutlined)

            Button("Large") { lastSelection = "Large" }
              .buttonStyle(.steadyOutlined(size: .large))
          }
        }

        demoSection("State") {
          HStack(spacing: theme.spacing.small) {
            Button("Enabled") { lastSelection = "Enabled" }
              .buttonStyle(.steadyPlain)

            Button("Disabled") {}
              .buttonStyle(.steadyPlain)
              .disabled(true)
          }
        }
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Action Buttons")
    .navigationBarTitleDisplayMode(.inline)
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
}
