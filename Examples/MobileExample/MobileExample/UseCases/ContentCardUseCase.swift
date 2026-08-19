import SteadyUI
import SwiftUI

/// Coordinates the card workflow and status state, which a Style or ViewModifier cannot provide.
struct ContentCardUseCase: View {
  @Environment(\.theme) private var theme
  @State private var status = "Ready"

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.large) {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
          Label("Weekly summary", systemImage: "chart.bar.fill")
            .font(theme.fonts.title.small)

          Text("12 tasks completed and 3 focus sessions scheduled.")
            .font(theme.fonts.body.medium)
            .foregroundStyle(theme.colors.text.secondary)

          HStack {
            Button("Share") { status = "Shared" }
              .buttonStyle(.steadyPlain)

            Button("Export") { status = "Exported" }
              .buttonStyle(.steadyOutlined)
          }
        }
        .steadyCard()

        Button { status = "Opened details" } label: {
          SteadyListRow(
            leading: { Image(systemName: "calendar") },
            content: { Text("Next focus session") },
            supporting: { Text("Today at 2:00 PM") },
            trailing: { Image(systemName: "arrow.up.right") }
          )
        }
        .buttonStyle(.steadyCard)

        Text("Status: \(status)")
          .font(theme.fonts.body.medium)
          .foregroundStyle(theme.colors.text.secondary)
      }
      .padding(theme.spacing.large)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Content Cards")
  }
}
