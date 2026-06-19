import SteadyUI
import SwiftUI

struct SwitchTabDemo: View {
  @Environment(\.theme) private var theme
  @State private var lastSelection = ViewMode.overview.title
  @State private var selectedViewMode = ViewMode.overview
  @State private var selectedBillingCycle = BillingCycle.monthly
  @State private var selectedOrderState = OrderState.pending
  @State private var selectedDisabledState = DisabledState.draft

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: theme.spacing.xLarge) {
        header
        basicSection
        variantsSection
        statesSection
      }
      .padding(theme.spacing.xLarge)
    }
    .background(theme.colors.background.base)
    .navigationTitle("Switch Tab")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("Switch Tab")
        .font(theme.fonts.display.small)
        .foregroundStyle(theme.colors.text.primary)

      Text("Last selection: \(lastSelection)")
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

  private var basicSection: some View {
    demoSection("Basic") {
      SteadySwitchTab(
        items: ViewMode.allCases,
        current: selectedViewMode,
        action: viewModeTabTapped
      )
    }
  }

  private var variantsSection: some View {
    demoSection("Variants") {
      VStack(alignment: .leading, spacing: theme.spacing.medium) {
        SteadySwitchTab(
          items: BillingCycle.allCases,
          current: selectedBillingCycle,
          action: billingCycleTabTapped
        )

        SteadySwitchTab(
          items: OrderState.allCases,
          current: selectedOrderState,
          action: orderStateTabTapped
        )
      }
    }
  }

  private var statesSection: some View {
    demoSection("States") {
      VStack(alignment: .leading, spacing: theme.spacing.medium) {
        SteadySwitchTab(
          items: OrderState.allCases,
          current: selectedOrderState,
          action: orderStateTabTapped
        )

        SteadySwitchTab(
          items: DisabledState.allCases,
          current: selectedDisabledState,
          action: disabledStateTabTapped
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

  private func viewModeTabTapped(_ item: ViewMode) {
    selectedViewMode = item
    lastSelection = item.title
  }

  private func billingCycleTabTapped(_ item: BillingCycle) {
    selectedBillingCycle = item
    lastSelection = item.title
  }

  private func orderStateTabTapped(_ item: OrderState) {
    selectedOrderState = item
    lastSelection = item.title
  }

  private func disabledStateTabTapped(_ item: DisabledState) {
    selectedDisabledState = item
    lastSelection = item.title
  }
}

private enum ViewMode: String, CaseIterable, SteadySwitchTabItem {
  case overview = "Overview"
  case activity = "Activity"
  case settings = "Settings"

  var id: Self { self }
  var title: String { rawValue }
}

private enum BillingCycle: String, CaseIterable, SteadySwitchTabItem {
  case monthly = "Monthly"
  case yearly = "Yearly"

  var id: Self { self }
  var title: String { rawValue }
}

private enum OrderState: String, CaseIterable, SteadySwitchTabItem {
  case pending = "Pending"
  case shipped = "Shipped"
  case delivered = "Delivered"

  var id: Self { self }
  var title: String { rawValue }
}

private enum DisabledState: String, CaseIterable, SteadySwitchTabItem {
  case draft = "Draft"
  case published = "Published"

  var id: Self { self }
  var title: String { rawValue }
}
