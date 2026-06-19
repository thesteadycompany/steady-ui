import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {
  static func steadyAdaptive(
    light: UInt,
    dark: UInt,
    lightOpacity: Double = 1,
    darkOpacity: Double? = nil
  ) -> Self {
    let resolvedDarkOpacity = darkOpacity ?? lightOpacity

#if canImport(UIKit)
    return Self(uiColor: UIColor { traitCollection in
      traitCollection.userInterfaceStyle == .dark
      ? .steadyColor(hex: dark, opacity: resolvedDarkOpacity)
      : .steadyColor(hex: light, opacity: lightOpacity)
    })
#elseif canImport(AppKit)
    return Self(nsColor: NSColor(name: nil) { appearance in
      appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
      ? .steadyColor(hex: dark, opacity: resolvedDarkOpacity)
      : .steadyColor(hex: light, opacity: lightOpacity)
    })
#else
    return Self(
      red: Double((light >> 16) & 0xFF) / 255,
      green: Double((light >> 8) & 0xFF) / 255,
      blue: Double(light & 0xFF) / 255,
      opacity: lightOpacity
    )
#endif
  }
}

#if canImport(UIKit)
extension UIColor {
  static func steadyColor(hex: UInt, opacity: Double) -> UIColor {
    let red = CGFloat((hex >> 16) & 0xFF) / 255
    let green = CGFloat((hex >> 8) & 0xFF) / 255
    let blue = CGFloat(hex & 0xFF) / 255

    return UIColor(
      red: red,
      green: green,
      blue: blue,
      alpha: opacity
    )
  }
}
#elseif canImport(AppKit)
extension NSColor {
  static func steadyColor(hex: UInt, opacity: Double) -> NSColor {
    let red = CGFloat((hex >> 16) & 0xFF) / 255
    let green = CGFloat((hex >> 8) & 0xFF) / 255
    let blue = CGFloat(hex & 0xFF) / 255

    return NSColor(
      srgbRed: red,
      green: green,
      blue: blue,
      alpha: opacity
    )
  }
}
#endif
