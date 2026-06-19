import SteadyUI
import SwiftUI

struct TextFieldDemo: View {
  @Environment(\.theme) private var theme
  @State private var smallText = ""
  @State private var mediumText = ""
  @State private var largeText = ""
  @State private var email = "hello@steady.co"
  @State private var company = "Steady"
  @State private var firstName = ""
  @State private var lastName = "Hong"

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        header
        sizesSection
        filledSection
        formSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Text Fields")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("Steady TextField")
        .font(theme.fonts.display.small)
        .foregroundStyle(theme.colors.text.primary)

      Text("Floating labels, theme spacing, and semantic sizes.")
        .font(theme.fonts.body.large)
        .foregroundStyle(theme.colors.text.secondary)
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

  private var sizesSection: some View {
    demoSection("Sizes") {
      fieldStack {
        SteadyTextField(text: $smallText, placeholder: "Small", size: .small)
        SteadyTextField(text: $mediumText, placeholder: "Medium")
        SteadyTextField(text: $largeText, placeholder: "Large", size: .large)
      }
    }
  }

  private var filledSection: some View {
    demoSection("Filled Values") {
      fieldStack {
        SteadyTextField(text: $email, placeholder: "Email")
          .keyboardType(.emailAddress)
        SteadyTextField(text: $company, placeholder: "Company")
      }
    }
  }

  private var formSection: some View {
    demoSection("Form") {
      fieldStack {
        SteadyTextField(text: $firstName, placeholder: "First Name")
        SteadyTextField(text: $lastName, placeholder: "Last Name")
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

  private func fieldStack<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(spacing: theme.spacing.xLarge) {
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
}
