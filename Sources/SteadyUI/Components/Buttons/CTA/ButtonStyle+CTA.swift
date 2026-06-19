import SwiftUI

extension ButtonStyle where Self == SteadyCTAButonStyle {
  public static var cta: Self {
    cta(.primary)
  }

  public static func cta(_ type: SteadyButtonType) -> Self {
    SteadyCTAButonStyle(type: type)
  }
}
