import SteadyUI
import SwiftUI

struct CTAButtonDemo: View {
  @Environment(\.theme) private var theme
  @State private var lastSelection = "None"

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        header
        typesSection
        statesSection
        contentSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("CTA Buttons")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("CTA Button")
        .font(theme.fonts.display.small)
        .foregroundStyle(theme.colors.text.primary)

      Text("Last action: \(lastSelection)")
        .font(theme.fonts.body.large)
        .foregroundStyle(theme.colors.text.secondary)
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

  private var typesSection: some View {
    demoSection("Types") {
      VStack(spacing: theme.spacing.medium) {
        Button {
          lastSelection = "Primary"
        } label: {
          Text("Continue")
        }
        .buttonStyle(.cta)

        Button {
          lastSelection = "Secondary"
        } label: {
          Text("Maybe Later")
        }
        .buttonStyle(.cta(.secondary))

        Button {
          lastSelection = "Destructive"
        } label: {
          Text("Delete")
        }
        .buttonStyle(.cta(.destructive))
      }
    }
  }

  private var statesSection: some View {
    demoSection("States") {
      VStack(spacing: theme.spacing.medium) {
        Button {
          lastSelection = "Enabled"
        } label: {
          Text("Enabled Button")
        }
        .buttonStyle(.cta)

        Button {
          lastSelection = "Disabled"
        } label: {
          Text("Disabled Button")
        }
        .buttonStyle(.cta)
        .disabled(true)
      }
    }
  }

  private var contentSection: some View {
    demoSection("Content") {
      VStack(spacing: theme.spacing.medium) {
        Button {
          lastSelection = "Leading icon"
        } label: {
          Label("Pay Now", systemImage: "creditcard.fill")
        }
        .buttonStyle(.cta)

        Button {
          lastSelection = "Plain text"
        } label: {
          Text("Button Content")
        }
        .buttonStyle(.cta)
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
}
