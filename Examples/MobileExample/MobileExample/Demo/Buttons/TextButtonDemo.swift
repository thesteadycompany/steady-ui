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
        .buttonStyle(.text)

        Button {
          lastSelection = "Secondary"
        } label: {
          Text("Maybe Later")
        }
        .buttonStyle(.text(.secondary))

        Button {
          lastSelection = "Destructive"
        } label: {
          Text("Delete")
        }
        .buttonStyle(.text(.destructive))
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
        .buttonStyle(.text(.primary, size: .small))

        Button {
          lastSelection = "Medium"
        } label: {
          Text("Medium")
        }
        .buttonStyle(.text)

        Button {
          lastSelection = "Large"
        } label: {
          Text("Large")
        }
        .buttonStyle(.text(.primary, size: .large))
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
        .buttonStyle(.text)

        Button {
          lastSelection = "Disabled"
        } label: {
          Text("Disabled Button")
        }
        .buttonStyle(.text)
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
        .buttonStyle(.text)

        Button {
          lastSelection = "Plain text"
        } label: {
          Text("Button Content")
        }
        .buttonStyle(.text(.secondary))
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
