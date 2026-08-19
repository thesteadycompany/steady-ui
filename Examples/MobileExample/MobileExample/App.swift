import SwiftUI

@main
struct MobileExampleApp: App {
  var body: some Scene {
    WindowGroup {
      RootView()
    }
  }
}

struct RootView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("Components") {
          ComponentsView()
        }

        Section("Use Cases") {
          NavigationLink("Settings Form") {
            SettingsFormUseCase()
          }

          NavigationLink("Content Cards") {
            ContentCardUseCase()
          }
        }
      }
      .navigationTitle("SteadyUI")
    }
  }
}

/// Coordinates categorized component navigation, which a Style or ViewModifier cannot provide.
private struct ComponentsView: View {
  var body: some View {
    List {
      Section("Foundations") {
        NavigationLink("Token") {
          TokenDemo()
        }
      }

      Section("Content") {
        NavigationLink("Badge") {
          BadgeDemo()
        }
      }

      Section("Selection") {
        NavigationLink("Toggle") {
          ToggleDemo()
        }

        NavigationLink("Switch Tab") {
          SwitchTabDemo()
        }
      }

      Section("Inputs") {
        NavigationLink("Box Text Field") {
          BoxTextFieldDemo()
        }

        NavigationLink("Line Text Field") {
          LineTextFieldDemo()
        }
      }

      Section("Actions") {
        NavigationLink("Action Buttons") {
          ActionButtonDemo()
        }

        NavigationLink("Interactive Surfaces") {
          InteractiveSurfaceDemo()
        }
      }

      Section("Layout") {
        NavigationLink("Bottom Scroll View") {
          BottomScrollViewDemo()
        }
      }
    }
    .navigationTitle("Components")
  }
}
