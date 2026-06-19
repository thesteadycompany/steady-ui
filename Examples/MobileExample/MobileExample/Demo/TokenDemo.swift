import SteadyUI
import SwiftUI

struct TokenDemo: View {
  @Environment(\.theme) private var theme

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        header
        colorSections
        fontSection
        spacingSection
        radiusSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Tokens")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("SteadyUI Theme")
        .font(theme.fonts.display.small)
        .foregroundStyle(theme.colors.text.primary)

      Text("Semantic color, font, spacing, and radius tokens from the active theme.")
        .font(theme.fonts.body.large)
        .foregroundStyle(theme.colors.text.secondary)

      HStack(spacing: theme.spacing.medium) {
        tokenBadge("Color")
        tokenBadge("Font")
        tokenBadge("Spacing")
        tokenBadge("Radius")
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

  private var colorSections: some View {
    VStack(alignment: .leading, spacing: theme.spacing.large) {
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
      LazyVGrid(columns: gridColumns, spacing: theme.spacing.medium) {
        statusCard("info", color: theme.colors.status.info)
        statusCard("success", color: theme.colors.status.success)
        statusCard("warning", color: theme.colors.status.warning)
        statusCard("critical", color: theme.colors.status.critical)
      }
    }
  }

  private var fontSection: some View {
    tokenSection("Font Tokens") {
      VStack(alignment: .leading, spacing: theme.spacing.medium) {
        fontScaleView("display", scale: theme.fonts.display)
        fontScaleView("title", scale: theme.fonts.title)
        fontScaleView("body", scale: theme.fonts.body)
        fontScaleView("label", scale: theme.fonts.label)
      }
    }
  }

  private var spacingSection: some View {
    tokenSection("Spacing Tokens") {
      LazyVGrid(columns: gridColumns, spacing: theme.spacing.medium) {
        spacingCard(.init("spacing.zero", theme.spacing.zero))
        spacingCard(.init("spacing.xSmall", theme.spacing.xSmall))
        spacingCard(.init("spacing.small", theme.spacing.small))
        spacingCard(.init("spacing.medium", theme.spacing.medium))
        spacingCard(.init("spacing.large", theme.spacing.large))
        spacingCard(.init("spacing.xLarge", theme.spacing.xLarge))
        spacingCard(.init("spacing.xxLarge", theme.spacing.xxLarge))
      }
    }
  }

  private var radiusSection: some View {
    tokenSection("Radius Tokens") {
      LazyVGrid(columns: gridColumns, spacing: theme.spacing.medium) {
        radiusCard(.init("radius.zero", theme.radius.zero))
        radiusCard(.init("radius.small", theme.radius.small))
        radiusCard(.init("radius.medium", theme.radius.medium))
        radiusCard(.init("radius.large", theme.radius.large))
        radiusCard(.init("radius.xLarge", theme.radius.xLarge))
      }
    }
  }

  private var gridColumns: [GridItem] {
    [GridItem(.adaptive(minimum: 150), spacing: theme.spacing.medium)]
  }

  private func colorSection(_ title: String, samples: [ColorSample]) -> some View {
    tokenSection(title) {
      LazyVGrid(columns: gridColumns, spacing: theme.spacing.medium) {
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
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(title)
        .font(theme.fonts.title.small)
        .foregroundStyle(theme.colors.text.primary)

      content()
    }
  }

  private func colorCard(_ sample: ColorSample) -> some View {
    HStack(spacing: theme.spacing.medium) {
      swatch(sample.color)

      VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
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
    .padding(theme.spacing.medium)
    .frame(minHeight: 72)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private func statusCard(_ name: String, color: StatusColor) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      Text(name)
        .font(theme.fonts.label.large)
        .foregroundStyle(color.foreground)

      Text("theme.colors.status.\(name)")
        .font(.caption.monospaced())
        .foregroundStyle(color.foreground.opacity(0.85))
        .lineLimit(1)
        .minimumScaleFactor(0.65)

      HStack(spacing: theme.spacing.small) {
        swatch(color.background)
        swatch(color.foreground)
        swatch(color.border)
      }
    }
    .padding(theme.spacing.medium)
    .frame(maxWidth: .infinity, minHeight: 124, alignment: .leading)
    .background(color.background)
    .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .stroke(color.border)
    }
  }

  private func fontScaleView(_ name: String, scale: FontScale) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      Text(name)
        .font(theme.fonts.label.large)
        .foregroundStyle(theme.colors.text.secondary)

      fontSample("large", font: scale.large)
      fontSample("medium", font: scale.medium)
      fontSample("small", font: scale.small)
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

  private func fontSample(_ size: String, font: Font) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
      Text("The quick steady fox")
        .font(font)
        .foregroundStyle(theme.colors.text.primary)
        .lineLimit(1)
        .minimumScaleFactor(0.7)

      Text(size)
        .font(.caption.monospaced())
        .foregroundStyle(theme.colors.text.tertiary)
    }
    .padding(.vertical, theme.spacing.xSmall)
  }

  private func spacingCard(_ sample: MetricSample) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      tokenName(sample.name, value: sample.value)

      HStack(spacing: sample.value) {
        metricBlock
        metricBlock
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      HStack(spacing: theme.spacing.small) {
        Text("gap")
          .font(theme.fonts.label.small)
          .foregroundStyle(theme.colors.text.tertiary)

        RoundedRectangle(cornerRadius: theme.radius.small, style: .continuous)
          .fill(theme.colors.action.primary.normal)
          .frame(width: max(sample.value, 1), height: 8)
      }
    }
    .padding(theme.spacing.medium)
    .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private func radiusCard(_ sample: MetricSample) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      tokenName(sample.name, value: sample.value)

      RoundedRectangle(cornerRadius: sample.value, style: .continuous)
        .fill(theme.colors.status.info.background)
        .frame(height: 64)
        .overlay {
          RoundedRectangle(cornerRadius: sample.value, style: .continuous)
            .stroke(theme.colors.status.info.border)
        }
    }
    .padding(theme.spacing.medium)
    .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private func tokenName(_ name: String, value: CGFloat) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
      Text("theme.\(name)")
        .font(.caption.monospaced())
        .foregroundStyle(theme.colors.text.primary)
        .lineLimit(1)
        .minimumScaleFactor(0.7)

      Text("\(Int(value))")
        .font(theme.fonts.label.small)
        .foregroundStyle(theme.colors.text.tertiary)
    }
  }

  private var metricBlock: some View {
    RoundedRectangle(cornerRadius: theme.radius.small, style: .continuous)
      .fill(theme.colors.background.subtle)
      .frame(width: 36, height: 36)
      .overlay {
        RoundedRectangle(cornerRadius: theme.radius.small, style: .continuous)
          .stroke(theme.colors.border.base)
      }
  }

  private func tokenBadge(_ title: String) -> some View {
    Text(title)
      .font(theme.fonts.label.small)
      .foregroundStyle(theme.colors.text.link)
      .padding(.horizontal, theme.spacing.medium)
      .padding(.vertical, theme.spacing.small)
      .background(theme.colors.status.info.background)
      .clipShape(Capsule())
      .overlay {
        Capsule()
          .stroke(theme.colors.status.info.border)
      }
  }

  private func swatch(_ color: Color) -> some View {
    RoundedRectangle(cornerRadius: theme.radius.small, style: .continuous)
      .fill(color)
      .frame(width: 40, height: 40)
      .overlay {
        RoundedRectangle(cornerRadius: theme.radius.small, style: .continuous)
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

private struct MetricSample: Identifiable {
  var name: String
  var value: CGFloat

  var id: String { name }

  init(_ name: String, _ value: CGFloat) {
    self.name = name
    self.value = value
  }
}
