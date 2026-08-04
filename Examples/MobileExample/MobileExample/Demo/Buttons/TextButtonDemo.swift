import SteadyUI
import SwiftUI

struct TextButtonDemo: View {
  @Environment(\.theme) private var theme
  @State private var lastSelection = "None"

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        header
        typesSection
        underlineSection
        sizesSection
        statesSection
        contentSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Text Buttons")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("Text Button")
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
      HStack(spacing: theme.spacing.medium) {
        Button {
          lastSelection = "Primary"
        } label: {
          Text("Continue")
        }
        .buttonStyle(.steadyText)

        Button {
          lastSelection = "Secondary"
        } label: {
          Text("Maybe Later")
        }
        .buttonStyle(.steadyText(.secondary))

        Button {
          lastSelection = "Destructive"
        } label: {
          Text("Delete")
        }
        .buttonStyle(.steadyText(.destructive))
      }
    }
  }

  private var underlineSection: some View {
    demoSection("Underline") {
      VStack(alignment: .leading, spacing: theme.spacing.medium) {
        HStack(spacing: theme.spacing.medium) {
          Button {
            lastSelection = "Underline Primary"
          } label: {
            Text("Continue")
          }
          .buttonStyle(.steadyUnderline)

          Button {
            lastSelection = "Underline Secondary"
          } label: {
            Text("Maybe Later")
          }
          .buttonStyle(.steadyUnderline(.secondary))

          Button {
            lastSelection = "Underline Destructive"
          } label: {
            Text("Delete")
          }
          .buttonStyle(.steadyUnderline(.destructive))
        }

        HStack(spacing: theme.spacing.medium) {
          Button {
            lastSelection = "Underline Small"
          } label: {
            Text("Small")
          }
          .buttonStyle(.steadyUnderline(.primary, size: .small))

          Button {
            lastSelection = "Underline Medium"
          } label: {
            Text("Medium")
          }
          .buttonStyle(.steadyUnderline)

          Button {
            lastSelection = "Underline Large"
          } label: {
            Text("Large")
          }
          .buttonStyle(.steadyUnderline(.primary, size: .large))
        }
      }
    }
  }

  private var sizesSection: some View {
    demoSection("Sizes") {
      HStack(spacing: theme.spacing.medium) {
        Button {
          lastSelection = "Small"
        } label: {
          Text("Small")
        }
        .buttonStyle(.steadyText(.primary, size: .small))

        Button {
          lastSelection = "Medium"
        } label: {
          Text("Medium")
        }
        .buttonStyle(.steadyText)

        Button {
          lastSelection = "Large"
        } label: {
          Text("Large")
        }
        .buttonStyle(.steadyText(.primary, size: .large))
      }
    }
  }

  private var statesSection: some View {
    demoSection("States") {
      HStack(spacing: theme.spacing.medium) {
        Button {
          lastSelection = "Enabled"
        } label: {
          Text("Enabled Button")
        }
        .buttonStyle(.steadyText)

        Button {
          lastSelection = "Disabled"
        } label: {
          Text("Disabled Button")
        }
        .buttonStyle(.steadyText)
        .disabled(true)
      }
    }
  }

  private var contentSection: some View {
    demoSection("Content") {
      HStack(spacing: theme.spacing.medium) {
        Button {
          lastSelection = "Leading icon"
        } label: {
          Label("Edit", systemImage: "pencil")
        }
        .buttonStyle(.steadyText)

        Button {
          lastSelection = "Plain text"
        } label: {
          Text("Button Content")
        }
        .buttonStyle(.steadyText(.secondary))
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
