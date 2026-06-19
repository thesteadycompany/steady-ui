import SwiftUI

public struct FontScale: Equatable, Sendable {
  public var large: Font
  public var medium: Font
  public var small: Font

  public init(
    large: Font,
    medium: Font,
    small: Font
  ) {
    self.large = large
    self.medium = medium
    self.small = small
  }
}

