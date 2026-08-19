import SteadyUI
import SwiftUI

struct InteractiveSurfaceDemo: View {
  @State private var notificationsEnabled = true
  @State private var lastAction = "None"

  var body: some View {
    List {
      Section("List Row") {
        Button { lastAction = "Refresh" } label: {
          SteadyListRow(
            leading: { Image(systemName: "arrow.clockwise") },
            content: { Text("Refresh account") },
            trailing: { Image(systemName: "chevron.right") }
          )
        }
        .buttonStyle(.steadyListRow)

        NavigationLink {
          Text("Navigation destination")
        } label: {
          SteadyListRow {
            Text("Open details")
          } supporting: {
            Text("NavigationLink keeps navigation semantics")
          }
        }

        Toggle(isOn: $notificationsEnabled) {
          SteadyListRow {
            Text("Product updates")
          } supporting: {
            Text("Toggle keeps selection semantics")
          }
        }
      }

      Section("Card") {
        VStack(alignment: .leading) {
          Text("Static card")
            .font(.headline)
          Text("A static card can contain multiple independent actions.")
          HStack {
            Button("Share") { lastAction = "Share" }
              .buttonStyle(.steadyPlain)
            Button("Save") { lastAction = "Save" }
              .buttonStyle(.steadyOutlined)
          }
        }
        .steadyCard()
        .listRowInsets(.init())

        Button { lastAction = "Interactive card" } label: {
          VStack(alignment: .leading) {
            Text("Single-action card")
              .font(.headline)
            Text("The whole surface has one action and no nested controls.")
          }
        }
        .buttonStyle(.steadyCard)
        .listRowInsets(.init())

        NavigationLink {
          Text("Card destination")
        } label: {
          VStack(alignment: .leading) {
            Text("Navigating card")
              .font(.headline)
            Text("NavigationLink owns the destination semantics.")
          }
        }
        .buttonStyle(.steadyCard)
        .listRowInsets(.init())
      }

      Section("Result") {
        Text(lastAction)
      }
    }
    .navigationTitle("Interactive Surfaces")
  }
}
