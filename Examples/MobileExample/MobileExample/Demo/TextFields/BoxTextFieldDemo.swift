import SteadyUI
import SwiftUI

struct BoxTextFieldDemo: View {
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
        labelSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Text Fields")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("BoxTextField")
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
        BoxTextField(text: $smallText, placeholder: "Small", size: .small)
        BoxTextField(text: $mediumText, placeholder: "Medium")
        BoxTextField(text: $largeText, placeholder: "Large", size: .large)
      }
    }
  }

  private var filledSection: some View {
    demoSection("Filled Values") {
      fieldStack {
        BoxTextField(text: $email, placeholder: "Email")
          .keyboardType(.emailAddress)
        BoxTextField(text: $company, placeholder: "Company")
      }
    }
  }

  private var formSection: some View {
    demoSection("Form") {
      fieldStack {
        BoxTextField(text: $firstName, placeholder: "First Name")
        BoxTextField(text: $lastName, placeholder: "Last Name")
      }
    }
  }

  private var labelSection: some View {
    demoSection("Label") {
      fieldStack {
        BoxTextField(text: $firstName, label: "Label Text", placeholder: "Label")
        BoxTextField(text: $lastName, placeholder: "No Label")
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
