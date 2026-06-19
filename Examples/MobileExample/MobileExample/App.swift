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
        }
      }
    }
  }
}
