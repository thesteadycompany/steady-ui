import Foundation

public struct FontTokens: Equatable, Sendable {
  public var display: FontScale
  public var title: FontScale
  public var body: FontScale
  public var label: FontScale

  public init(
    display: FontScale,
    title: FontScale,
    body: FontScale,
    label: FontScale
  ) {
    self.display = display
    self.title = title
    self.body = body
    self.label = label
  }
}
