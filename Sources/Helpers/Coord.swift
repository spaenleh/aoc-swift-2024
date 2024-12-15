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

  static let up = Coord(x: 0, y: -1)
  static let right = Coord(x: 1, y: 0)
  static let down = Coord(x: 0, y: 1)
  static let left = Coord(x: -1, y: 0)
  /// Offsets for the cross elements (+ shape)
  /// up, right, down, left
  static let cross = [
    //north
    up,
    // east
    right,
    // south
    down,
    // west
    left,
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
}

extension Coord: Equatable {}

extension Coord: Hashable {}

extension Coord: RawRepresentable {
  init?(rawValue: String) {
    let parts = rawValue.integers(separator: ",")
    x = parts[0]
    y = parts[1]
  }

  var rawValue: String {
    "(\(x),\(y))"
  }

  typealias RawValue = String
}

extension Coord: CustomStringConvertible {
  var description: String {
    "\(x),\(y)"
  }
}

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

extension Coord {
  static func / (lhs: Coord, rhs: Int) -> Coord {
    return Self(x: lhs.x / rhs, y: lhs.y / rhs)
  }

  static func * (lhs: Coord, rhs: Int) -> Coord {
    return Self(x: lhs.x * rhs, y: lhs.y * rhs)
  }
}
