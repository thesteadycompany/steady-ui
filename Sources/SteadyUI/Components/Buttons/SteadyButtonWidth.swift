import Foundation

/// The horizontal sizing behavior of a SteadyUI action button.
public enum SteadyButtonWidth: Equatable, Sendable {
  /// Size the button to its label and padding.
  case fitted
  /// Fill the width proposed by the button's container.
  case expanded
}
