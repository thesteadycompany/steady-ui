import SteadyUI
import SwiftUI

struct BottomScrollViewDemo: View {
  @Environment(\.theme) private var theme
  @State private var hideOnScroll = true

  var body: some View {
    SteadyBottomScrollView(hideOnScroll: hideOnScroll) {
      VStack(alignment: .leading, spacing: theme.spacing.large) {
        summary
        behaviorSection
        todaySection
        habitSection
        notesSection
      }
      .padding(theme.spacing.medium)
    } bottom: {
      VStack(spacing: theme.spacing.small) {
        Divider()

        HStack(spacing: theme.spacing.small) {
          Button {
          } label: {
            Label("Later", systemImage: "clock")
          }
          .buttonStyle(.cta(.secondary))

          Button {
          } label: {
            Label("Start", systemImage: "play.fill")
          }
          .buttonStyle(.cta)
        }
        .padding(.horizontal, theme.spacing.medium)
        .padding(.bottom, theme.spacing.small)
      }
      .background(theme.colors.background.base)
    }
    .background(theme.colors.background.subtle)
    .navigationTitle("Focus Plan")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var summary: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      HStack {
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
          Text("Today")
            .font(theme.fonts.label.medium)
            .foregroundStyle(theme.colors.text.secondary)

          Text("Build a calmer launch rhythm")
            .font(theme.fonts.title.large)
            .foregroundStyle(theme.colors.text.primary)
        }

        Spacer()

        Image(systemName: "sparkles")
          .font(theme.fonts.title.medium)
          .foregroundStyle(theme.colors.status.warning.foreground)
          .padding(theme.spacing.medium)
          .background(theme.colors.status.warning.background, in: .circle)
      }

      Text("Three focused blocks, two recovery windows, and one decision checkpoint before the day wraps.")
        .font(theme.fonts.body.medium)
        .foregroundStyle(theme.colors.text.secondary)
    }
    .padding(theme.spacing.large)
    .background(theme.colors.background.base, in: .rect(cornerRadius: theme.radius.large))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.large)
        .stroke(theme.colors.border.subtle)
    }
  }

  private var todaySection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      sectionTitle("Focus blocks")

      ForEach(focusBlocks) { block in
        BottomScrollDemoRow(item: block)
      }
    }
  }

  private var behaviorSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      sectionTitle("Behavior")

      HStack(spacing: theme.spacing.medium) {
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
          Text("Hide bottom action")
            .font(theme.fonts.label.large)
            .foregroundStyle(theme.colors.text.primary)

          Text("Scroll down to hide, scroll up to show.")
            .font(theme.fonts.body.small)
            .foregroundStyle(theme.colors.text.secondary)
        }

        Spacer()

        SteadyToggle(isOn: $hideOnScroll)
      }
      .padding(theme.spacing.medium)
      .background(theme.colors.background.base, in: .rect(cornerRadius: theme.radius.medium))
    }
  }

  private var habitSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      sectionTitle("Recovery")

      ForEach(recoveryItems) { item in
        BottomScrollDemoRow(item: item)
      }
    }
  }

  private var notesSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      sectionTitle("Checkpoint")

      VStack(alignment: .leading, spacing: theme.spacing.small) {
        Text("Ship the smallest useful change first, then review what still feels sharp around the edges.")
          .font(theme.fonts.body.medium)
          .foregroundStyle(theme.colors.text.primary)

        Text("Owner: Product and Design")
          .font(theme.fonts.label.small)
          .foregroundStyle(theme.colors.text.tertiary)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(theme.spacing.medium)
      .background(theme.colors.background.base, in: .rect(cornerRadius: theme.radius.medium))
    }
  }

  private func sectionTitle(_ title: String) -> some View {
    Text(title)
      .font(theme.fonts.label.large)
      .foregroundStyle(theme.colors.text.secondary)
  }

  private var focusBlocks: [BottomScrollDemoItem] {
    [
      .init(icon: "target", title: "Morning scope", subtitle: "Pick the single outcome that makes the day count."),
      .init(icon: "paintbrush.pointed", title: "Design pass", subtitle: "Tighten spacing, labels, and the primary action path."),
      .init(icon: "hammer", title: "Implementation", subtitle: "Finish the component behavior and keep the example app honest."),
      .init(icon: "checkmark.seal", title: "Review", subtitle: "Build, run, and verify the scroll interaction in context."),
    ]
  }

  private var recoveryItems: [BottomScrollDemoItem] {
    [
      .init(icon: "cup.and.saucer", title: "Midday reset", subtitle: "Step away before the next decision gets expensive."),
      .init(icon: "moon", title: "Shutdown note", subtitle: "Write down what changed and what should wait."),
    ]
  }
}

private struct BottomScrollDemoItem: Identifiable {
  var id: String { title }
  let icon: String
  let title: String
  let subtitle: String
}

private struct BottomScrollDemoRow: View {
  @Environment(\.theme) private var theme
  let item: BottomScrollDemoItem

  var body: some View {
    HStack(alignment: .top, spacing: theme.spacing.medium) {
      Image(systemName: item.icon)
        .font(theme.fonts.label.large)
        .foregroundStyle(theme.colors.status.info.foreground)
        .frame(width: 36, height: 36)
        .background(theme.colors.status.info.background, in: .circle)

      VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
        Text(item.title)
          .font(theme.fonts.label.large)
          .foregroundStyle(theme.colors.text.primary)

        Text(item.subtitle)
          .font(theme.fonts.body.small)
          .foregroundStyle(theme.colors.text.secondary)
      }

      Spacer(minLength: theme.spacing.small)
    }
    .padding(theme.spacing.medium)
    .background(theme.colors.background.base, in: .rect(cornerRadius: theme.radius.medium))
  }
}
