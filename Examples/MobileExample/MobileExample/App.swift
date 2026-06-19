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
      Form {
        Section {
          NavigationLink("Token") {
            TokenDemo()
          }
          NavigationLink("Badge") {
            BadgeDemo()
          }

          NavigationLink("TextField") {
            TextFieldDemo()
          }

          NavigationLink("Toggle") {
            ToggleDemo()
          }
        }

        Section {
          NavigationLink("Switch Tab") {
            SwitchTabDemo()
          }
        } header: {
          Text("Switch Tabs")
        }

        Section {
          NavigationLink("CTA Button") {
            CTAButtonDemo()
          }

          NavigationLink("Text Button") {
            TextButtonDemo()
          }
        } header: {
          Text("Buttons")
        }
      }
    }
  }
}
