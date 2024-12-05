struct Grid {
  typealias Element = Character

  var raw: [[Element]]

  // dimensions
  var width: Int {
    raw[0].count
  }
  var height: Int {
    raw.count
  }

  subscript(_ coord: Coord) -> Element {
    raw[coord.y][coord.x]
  }

  subscript(col: Int, row: Int) -> Element {
    raw[row][col]
  }
}

extension Grid {
  /// creates a Grid of characters from a multiline string
  init(from data: String) {
    self.raw = data.lines().map { Array($0) }
  }

  func toText() -> String {
    String(
      self.raw.map {
        String($0)
      }.joined(by: "\n"))
  }

  func includes(coord: Coord) -> Bool {
    coord.x >= 0 && coord.x <= self.width - 1 && coord.y >= 0 && coord.y <= self.height - 1
  }
}
