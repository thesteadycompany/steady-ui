import SteadyUI
import SwiftUI

struct TokenDemo: View {
  @Environment(\.theme) private var theme

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 24) {
        header
        colorSections
        fontSection
      }
      .padding(20)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Tokens")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("SteadyUI Theme")
        .font(theme.fonts.display.small)
        .foregroundStyle(theme.colors.text.primary)

      Text("Semantic color and font tokens from the active theme.")
        .font(theme.fonts.body.large)
        .foregroundStyle(theme.colors.text.secondary)

      HStack(spacing: 12) {
        tokenBadge("Color")
        tokenBadge("Font")
        tokenBadge("Dark Mode")
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(20)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private var colorSections: some View {
    VStack(alignment: .leading, spacing: 18) {
      colorSection(
        "Action Colors",
        samples: [
          .init("action.primary.normal", theme.colors.action.primary.normal),
          .init("action.primary.pressed", theme.colors.action.primary.pressed),
          .init("action.primary.disabled", theme.colors.action.primary.disabled),
          .init("action.secondary.normal", theme.colors.action.secondary.normal),
          .init("action.secondary.pressed", theme.colors.action.secondary.pressed),
          .init("action.secondary.disabled", theme.colors.action.secondary.disabled),
          .init("action.destructive.normal", theme.colors.action.destructive.normal),
          .init("action.destructive.pressed", theme.colors.action.destructive.pressed),
          .init("action.destructive.disabled", theme.colors.action.destructive.disabled),
        ]
      )

      colorSection(
        "Background Colors",
        samples: [
          .init("background.base", theme.colors.background.base),
          .init("background.subtle", theme.colors.background.subtle),
          .init("background.elevated", theme.colors.background.elevated),
          .init("background.overlay", theme.colors.background.overlay),
          .init("background.inverse", theme.colors.background.inverse),
        ]
      )

      colorSection(
        "Text Colors",
        samples: [
          .init("text.primary", theme.colors.text.primary),
          .init("text.secondary", theme.colors.text.secondary),
          .init("text.tertiary", theme.colors.text.tertiary),
          .init("text.disabled", theme.colors.text.disabled),
          .init("text.inverse", theme.colors.text.inverse),
          .init("text.link", theme.colors.text.link),
          .init("text.destructive", theme.colors.text.destructive),
        ]
      )

      colorSection(
        "Icon Colors",
        samples: [
          .init("icon.primary", theme.colors.icon.primary),
          .init("icon.secondary", theme.colors.icon.secondary),
          .init("icon.tertiary", theme.colors.icon.tertiary),
          .init("icon.disabled", theme.colors.icon.disabled),
          .init("icon.inverse", theme.colors.icon.inverse),
          .init("icon.destructive", theme.colors.icon.destructive),
        ]
      )

      colorSection(
        "Border Colors",
        samples: [
          .init("border.base", theme.colors.border.base),
          .init("border.subtle", theme.colors.border.subtle),
          .init("border.strong", theme.colors.border.strong),
          .init("border.focus", theme.colors.border.focus),
          .init("border.disabled", theme.colors.border.disabled),
          .init("border.destructive", theme.colors.border.destructive),
        ]
      )

      statusSection
    }
  }

  private var statusSection: some View {
    tokenSection("Status Colors") {
      LazyVGrid(columns: gridColumns, spacing: 12) {
        statusCard("info", color: theme.colors.status.info)
        statusCard("success", color: theme.colors.status.success)
        statusCard("warning", color: theme.colors.status.warning)
        statusCard("critical", color: theme.colors.status.critical)
      }
    }
  }

  private var fontSection: some View {
    tokenSection("Font Tokens") {
      VStack(alignment: .leading, spacing: 12) {
        fontScaleView("display", scale: theme.fonts.display)
        fontScaleView("title", scale: theme.fonts.title)
        fontScaleView("body", scale: theme.fonts.body)
        fontScaleView("label", scale: theme.fonts.label)
      }
    }
  }

  private var gridColumns: [GridItem] {
    [GridItem(.adaptive(minimum: 150), spacing: 12)]
  }

  private func colorSection(_ title: String, samples: [ColorSample]) -> some View {
    tokenSection(title) {
      LazyVGrid(columns: gridColumns, spacing: 12) {
        ForEach(samples) { sample in
          colorCard(sample)
        }
      }
    }
  }

  private func tokenSection<Content: View>(
    _ title: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(theme.fonts.title.small)
        .foregroundStyle(theme.colors.text.primary)

      content()
    }
  }

  private func colorCard(_ sample: ColorSample) -> some View {
    HStack(spacing: 12) {
      swatch(sample.color)

      VStack(alignment: .leading, spacing: 4) {
        Text(sample.name)
          .font(.caption.monospaced())
          .foregroundStyle(theme.colors.text.primary)
          .lineLimit(1)
          .minimumScaleFactor(0.75)

        Text("theme.colors.\(sample.name)")
          .font(theme.fonts.label.small)
          .foregroundStyle(theme.colors.text.tertiary)
          .lineLimit(1)
          .minimumScaleFactor(0.65)
      }

      Spacer(minLength: 0)
    }
    .padding(12)
    .frame(minHeight: 72)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private func statusCard(_ name: String, color: StatusColor) -> some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(name)
        .font(theme.fonts.label.large)
        .foregroundStyle(color.foreground)

      Text("theme.colors.status.\(name)")
        .font(.caption.monospaced())
        .foregroundStyle(color.foreground.opacity(0.85))
        .lineLimit(1)
        .minimumScaleFactor(0.65)

      HStack(spacing: 8) {
        swatch(color.background)
        swatch(color.foreground)
        swatch(color.border)
      }
    }
    .padding(12)
    .frame(maxWidth: .infinity, minHeight: 124, alignment: .leading)
    .background(color.background)
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .stroke(color.border)
    }
  }

  private func fontScaleView(_ name: String, scale: FontScale) -> some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(name)
        .font(theme.fonts.label.large)
        .foregroundStyle(theme.colors.text.secondary)

      fontSample("large", font: scale.large)
      fontSample("medium", font: scale.medium)
      fontSample("small", font: scale.small)
    }
    .padding(14)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private func fontSample(_ size: String, font: Font) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Text("The quick steady fox")
        .font(font)
        .foregroundStyle(theme.colors.text.primary)
        .lineLimit(1)
        .minimumScaleFactor(0.7)

      Text(size)
        .font(.caption.monospaced())
        .foregroundStyle(theme.colors.text.tertiary)
    }
    .padding(.vertical, 4)
  }

  private func tokenBadge(_ title: String) -> some View {
    Text(title)
      .font(theme.fonts.label.small)
      .foregroundStyle(theme.colors.text.link)
      .padding(.horizontal, 10)
      .padding(.vertical, 6)
      .background(theme.colors.status.info.background)
      .clipShape(Capsule())
      .overlay {
        Capsule()
          .stroke(theme.colors.status.info.border)
      }
  }

  private func swatch(_ color: Color) -> some View {
    RoundedRectangle(cornerRadius: 6, style: .continuous)
      .fill(color)
      .frame(width: 40, height: 40)
      .overlay {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
          .stroke(theme.colors.border.subtle)
      }
  }
}

private struct ColorSample: Identifiable {
  var name: String
  var color: Color

  var id: String { name }

  init(_ name: String, _ color: Color) {
    self.name = name
    self.color = color
  }
}
