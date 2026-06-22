import SwiftUI

public struct SteadyBottomScrollView<
  Content: View,
  Bottom: View
>: View {
  private let hideOnScroll: Bool
  private let content: Content
  private let bottom: Bottom

  @State private var bottomHeight: CGFloat = .zero
  @State private var hideBottomView = false

  public init(
    hideOnScroll: Bool = true,
    @ViewBuilder content: () -> Content,
    @ViewBuilder bottom: () -> Bottom
  ) {
    self.hideOnScroll = hideOnScroll
    self.content = content()
    self.bottom = bottom()
  }

  public var body: some View {
    ZStack(alignment: .bottom) {
      ScrollView {
        VStack(spacing: .zero) {
          content

          Color.clear
            .frame(height: bottomHeight)
        }
      }
      .onScrollGeometryChange(for: CGFloat.self) { geometry in
        geometry.contentOffset.y
      } action: { oldOffset, newOffset in
        scrollOffsetChanged(from: oldOffset, to: newOffset)
      }

      bottom
        .opacity(isBottomViewHidden ? 0 : 1)
        .offset(y: isBottomViewHidden ? bottomHeight : 0)
        .allowsHitTesting(!isBottomViewHidden)
        .onGeometryChange(for: CGFloat.self) { geometry in
          geometry.size.height
        } action: { height in
          bottomHeight = height
        }
    }
    .onChange(of: hideOnScroll) { _, hideOnScroll in
      guard !hideOnScroll else { return }
      setBottomViewHidden(false)
    }
  }

  private func scrollOffsetChanged(from oldOffset: CGFloat, to newOffset: CGFloat) {
    guard hideOnScroll else {
      setBottomViewHidden(false)
      return
    }

    let delta = newOffset - oldOffset

    guard abs(delta) > 4 else { return }

    if newOffset <= 0 {
      setBottomViewHidden(false)
    } else {
      setBottomViewHidden(delta > 0)
    }
  }

  private func setBottomViewHidden(_ isHidden: Bool) {
    guard hideBottomView != isHidden else { return }

    withAnimation(.easeInOut(duration: 0.2)) {
      hideBottomView = isHidden
    }
  }

  private var isBottomViewHidden: Bool {
    hideOnScroll && hideBottomView
  }
}
