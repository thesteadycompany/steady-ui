import SteadyUI
import SwiftUI

struct SettingsFormUseCase: View {
  @State private var notificationsEnabled = true
  @State private var isSaved = false

  var body: some View {
    Form {
      Section("Account") {
        SteadyListRow(
          leading: { Image(systemName: "person.2") },
          content: { Text("Workspace") },
          supporting: { Text("Steady Team") },
          trailing: {
            SteadyBadge(
              isSaved ? "Saved" : "Active",
              role: isSaved ? .success : .info,
              emphasis: .secondary
            )
          }
        )

        Button("Reset preferences", action: resetPreferencesButtonTapped)
          .buttonStyle(.steadyPlain(tone: .neutral))
      }

      Section("Notifications") {
        SteadyListRow(
          content: { Text("Product updates") },
          trailing: {
            SteadyToggle(isOn: $notificationsEnabled)
              .accessibilityLabel("Product updates")
          }
        )
      }

      Section {
        Button("Save changes", action: saveChangesButtonTapped)
          .buttonStyle(.steadyFilled(width: .expanded))
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
