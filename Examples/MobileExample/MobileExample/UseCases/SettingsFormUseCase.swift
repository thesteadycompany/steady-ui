import SteadyUI
import SwiftUI

struct SettingsFormUseCase: View {
  @Environment(\.theme) private var theme
  @State private var notificationsEnabled = true
  @State private var isSaved = false

  var body: some View {
    Form {
      Section("Account") {
        HStack {
          VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            Text("Workspace")
              .font(theme.fonts.label.large)
            Text("Steady Team")
              .font(theme.fonts.body.medium)
              .foregroundStyle(theme.colors.text.secondary)
          }

          Spacer()

          SteadyBadge(
            isSaved ? "Saved" : "Active",
            role: isSaved ? .success : .info,
            emphasis: .secondary
          )
        }

        Button("Reset preferences", action: resetPreferencesButtonTapped)
          .buttonStyle(.steadyText(.secondary))
      }

      Section("Notifications") {
        HStack {
          Text("Product updates")
          Spacer()
          SteadyToggle(isOn: $notificationsEnabled)
            .accessibilityLabel("Product updates")
        }
      }

      Section {
        Button("Save changes", action: saveChangesButtonTapped)
          .buttonStyle(.steadyCTA)
      }
    }
    .navigationTitle("Settings Form")
    .onChange(of: notificationsEnabled) {
      isSaved = false
    }
  }

  private func resetPreferencesButtonTapped() {
    notificationsEnabled = false
    isSaved = false
  }

  private func saveChangesButtonTapped() {
    isSaved = true
  }
}
