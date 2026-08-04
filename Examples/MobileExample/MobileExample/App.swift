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

          NavigationLink("Toggle") {
            ToggleDemo()
          }
        }

        Section {
          NavigationLink("BoxTextField") {
            BoxTextFieldDemo()
          }
          
          NavigationLink("LineTextField") {
            LineTextFieldDemo()
          }
        } header: {
          Text("TextFields")
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

        Section {
          NavigationLink("Bottom ScrollView") {
            BottomScrollViewDemo()
          }
        } header: {
          Text("ScrollViews")
        }

        Section {
          NavigationLink("Settings Form") {
            SettingsFormUseCase()
          }
        } header: {
          Text("Use Cases")
        }
      }
    }
  }
}
