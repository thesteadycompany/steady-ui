import SteadyUI
import SwiftUI

struct ToggleDemo: View {
  @Environment(\.theme) private var theme
  @State private var notificationsEnabled = true
  @State private var syncEnabled = false
  @State private var compactModeEnabled = true
  @State private var disabledOn = true
  @State private var disabledOff = false

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        header
        settingsSection
        statesSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Toggles")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("Steady Toggle")
        .font(theme.fonts.display.small)
        .foregroundStyle(theme.colors.text.primary)

      Text("A theme-aware switch with spring animation and disabled states.")
        .font(theme.fonts.body.large)
        .foregroundStyle(theme.colors.text.secondary)

      HStack(spacing: theme.spacing.medium) {
        SteadyToggle(isOn: $notificationsEnabled)

        Text(notificationsEnabled ? "On" : "Off")
          .font(theme.fonts.label.medium)
          .foregroundStyle(theme.colors.text.secondary)
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

  private var settingsSection: some View {
    demoSection("Settings") {
      toggleStack {
        toggleRow(
          "Notifications",
          description: "Receive product updates and reminders.",
          isOn: $notificationsEnabled
        )

        toggleRow(
          "Background Sync",
          description: "Keep local data fresh while the app is open.",
          isOn: $syncEnabled
        )

        toggleRow(
          "Compact Mode",
          description: "Use tighter spacing in dense screens.",
          isOn: $compactModeEnabled
        )
      }
    }
  }

  private var statesSection: some View {
    demoSection("States") {
      toggleStack {
        toggleRow(
          "Enabled On",
          description: "Interactive selected state.",
          isOn: $notificationsEnabled
        )

        toggleRow(
          "Disabled On",
          description: "Selected state when unavailable.",
          isOn: $disabledOn
        )
        .disabled(true)

        toggleRow(
          "Disabled Off",
          description: "Unselected state when unavailable.",
          isOn: $disabledOff
        )
        .disabled(true)
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

  private func toggleStack<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(spacing: theme.spacing.large) {
      content()
    }
    .padding(theme.spacing.large)
    .background(theme.colors.background.elevated)
    .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .stroke(theme.colors.border.subtle)
    }
  }

  private func toggleRow(
    _ title: String,
    description: String,
    isOn: Binding<Bool>
  ) -> some View {
    HStack(alignment: .center, spacing: theme.spacing.large) {
      VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
        Text(title)
          .font(theme.fonts.label.large)
          .foregroundStyle(theme.colors.text.primary)

        Text(description)
          .font(theme.fonts.body.medium)
          .foregroundStyle(theme.colors.text.secondary)
          .fixedSize(horizontal: false, vertical: true)
      }

      Spacer(minLength: theme.spacing.large)

      SteadyToggle(isOn: isOn)
        .accessibilityLabel(title)
    }
  }
}
