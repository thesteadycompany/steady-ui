import SwiftUI

extension ButtonStyle where Self == SteadyCTAButtonStyle {
  public static var steadyCTA: Self {
    steadyCTA(.primary)
  }

  public static func steadyCTA(_ variant: SteadyButtonVariant) -> Self {
    SteadyCTAButtonStyle(variant: variant)
  }
}
