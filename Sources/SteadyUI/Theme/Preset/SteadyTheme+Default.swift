import SwiftUI

extension SteadyTheme {
  public static let `default` = Self(
    colors: .default,
    fonts: .default,
    radius: .default,
    spacing: .default
  )
}

extension ColorTokens {
  public static let `default` = Self(
    action: .default,
    background: .default,
    border: .default,
    icon: .default,
    status: .default,
    text: .default
  )
}

extension ActionColors {
  public static let `default` = Self(
    primary: .init(
      normal: .steadyAdaptive(light: 0x2563EB, dark: 0x3B82F6),
      pressed: .steadyAdaptive(light: 0x1D4ED8, dark: 0x2563EB),
      disabled: .steadyAdaptive(light: 0xD1D5DB, dark: 0x374151)
    ),
    secondary: .init(
      normal: .steadyAdaptive(light: 0xE5E7EB, dark: 0x374151),
      pressed: .steadyAdaptive(light: 0xD1D5DB, dark: 0x4B5563),
      disabled: .steadyAdaptive(light: 0xF3F4F6, dark: 0x1F2937)
    ),
    destructive: .init(
      normal: .steadyAdaptive(light: 0xDC2626, dark: 0xEF4444),
      pressed: .steadyAdaptive(light: 0xB91C1C, dark: 0xDC2626),
      disabled: .steadyAdaptive(light: 0xD1D5DB, dark: 0x374151)
    )
  )
}

extension BackgroundColors {
  public static let `default` = Self(
    base: .steadyAdaptive(light: 0xFFFFFF, dark: 0x101114),
    subtle: .steadyAdaptive(light: 0xF6F7F9, dark: 0x181B20),
    elevated: .steadyAdaptive(light: 0xE8E8E8, dark: 0x20242B),
    overlay: .steadyAdaptive(
      light: 0x000000,
      dark: 0x000000,
      lightOpacity: 0.45,
      darkOpacity: 0.65
    ),
    inverse: .steadyAdaptive(light: 0x111827, dark: 0xF9FAFB)
  )
}

extension BorderColors {
  public static let `default` = Self(
    base: .steadyAdaptive(light: 0xD1D5DB, dark: 0x374151),
    subtle: .steadyAdaptive(light: 0xE5E7EB, dark: 0x1F2937),
    strong: .steadyAdaptive(light: 0x9CA3AF, dark: 0x4B5563),
    focus: .steadyAdaptive(light: 0x2563EB, dark: 0x60A5FA),
    disabled: .steadyAdaptive(light: 0xE5E7EB, dark: 0x374151),
    destructive: .steadyAdaptive(light: 0xDC2626, dark: 0xF87171)
  )
}

extension IconColors {
  public static let `default` = Self(
    primary: .steadyAdaptive(light: 0x111827, dark: 0xF9FAFB),
    secondary: .steadyAdaptive(light: 0x4B5563, dark: 0xD1D5DB),
    tertiary: .steadyAdaptive(light: 0x6B7280, dark: 0x9CA3AF),
    disabled: .steadyAdaptive(light: 0x9CA3AF, dark: 0x6B7280),
    inverse: .steadyAdaptive(light: 0xFFFFFF, dark: 0x111827),
    destructive: .steadyAdaptive(light: 0xDC2626, dark: 0xF87171)
  )
}

extension StatusColors {
  public static let `default` = Self(
    info: .init(
      background: .steadyAdaptive(light: 0xEFF6FF, dark: 0x172554),
      foreground: .steadyAdaptive(light: 0x1D4ED8, dark: 0x93C5FD),
      border: .steadyAdaptive(light: 0xBFDBFE, dark: 0x1E40AF)
    ),
    success: .init(
      background: .steadyAdaptive(light: 0xF0FDF4, dark: 0x052E16),
      foreground: .steadyAdaptive(light: 0x15803D, dark: 0x86EFAC),
      border: .steadyAdaptive(light: 0xBBF7D0, dark: 0x166534)
    ),
    warning: .init(
      background: .steadyAdaptive(light: 0xFFFBEB, dark: 0x451A03),
      foreground: .steadyAdaptive(light: 0xB45309, dark: 0xFCD34D),
      border: .steadyAdaptive(light: 0xFDE68A, dark: 0x92400E)
    ),
    critical: .init(
      background: .steadyAdaptive(light: 0xFEF2F2, dark: 0x450A0A),
      foreground: .steadyAdaptive(light: 0xB91C1C, dark: 0xFCA5A5),
      border: .steadyAdaptive(light: 0xFECACA, dark: 0x991B1B)
    )
  )
}

extension TextColors {
  public static let `default` = Self(
    primary: .steadyAdaptive(light: 0x111827, dark: 0xF9FAFB),
    secondary: .steadyAdaptive(light: 0x4B5563, dark: 0xD1D5DB),
    tertiary: .steadyAdaptive(light: 0x6B7280, dark: 0x9CA3AF),
    disabled: .steadyAdaptive(light: 0x9CA3AF, dark: 0x6B7280),
    inverse: .steadyAdaptive(light: 0xFFFFFF, dark: 0x111827),
    link: .steadyAdaptive(light: 0x2563EB, dark: 0x60A5FA),
    destructive: .steadyAdaptive(light: 0xDC2626, dark: 0xF87171)
  )
}

extension FontTokens {
  public static let `default` = Self(
    display: .init(
      large: .largeTitle.weight(.bold),
      medium: .title.weight(.bold),
      small: .title2.weight(.semibold)
    ),
    title: .init(
      large: .title.weight(.semibold),
      medium: .title2.weight(.semibold),
      small: .title3.weight(.semibold)
    ),
    body: .init(
      large: .body,
      medium: .callout,
      small: .footnote
    ),
    label: .init(
      large: .headline.weight(.semibold),
      medium: .subheadline.weight(.medium),
      small: .caption.weight(.medium)
    )
  )
}

extension RadiusTokens {
  public static let `default` = Self(
    zero: 0,
    small: 4,
    medium: 8,
    large: 12,
    xLarge: 16
  )
}

extension SpacingTokens {
  public static let `default` = Self(
    zero: 0,
    xSmall: 4,
    small: 8,
    medium: 12,
    large: 16,
    xLarge: 24,
    xxLarge: 32
  )
}
