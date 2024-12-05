struct Coord {
  var x: Int
  var y: Int

  /// Offsets for the corner elements (X shape)
  /// Corners are ordered clockwise starting at the top left
  /// top left, top right, bottom right, bottom left
  static let corners = [
    Coord(x: -1, y: -1),
    Coord(x: 1, y: -1),
    Coord(x: 1, y: 1),
    Coord(x: -1, y: 1),
  ]

  /// Offsets for the cross elements (+ shape)
  ///
  static let cross = [
    Coord(x: 0, y: -1),
    Coord(x: 0, y: 1),
    Coord(x: -1, y: 0),
    Coord(x: 1, y: 0),
  ]

  var cornerNeighbors: [Coord] {
    Coord.corners.map { self + $0 }
  }

  var crossNeighbors: [Coord] {
    Coord.cross.map { self + $0 }
  }

  var fullNeighbors: [Coord] {
    self.cornerNeighbors + self.crossNeighbors
  }

  func isInside(grid: Grid) -> Bool {
    self.x >= 0 && self.x <= grid.width - 1 && self.y >= 0 && self.y <= grid.height - 1
  }

}

extension Coord: Equatable {}

extension Coord: AdditiveArithmetic {
  static let zero = Coord(x: 0, y: 0)

  // add conformance for the AdditiveArithmetic protocol
  static func + (lhs: Self, rhs: Self) -> Self {
    return Self(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  static func - (lhs: Self, rhs: Self) -> Self {
    return Self(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
  }
}

extension Array where Array.Element == Coord {
  func included(in grid: Grid) -> Self {
    self.filter { $0.isInside(grid: grid) }
  }
}