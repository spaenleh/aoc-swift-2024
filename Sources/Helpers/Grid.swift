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

  subscript(_ coord: Coord) -> Element? {
    if coord.isInside(grid: self) {
      return raw[coord.y][coord.x]
    }
    return nil
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

  func firstCoord(of char: Character) -> Coord? {
    let index = self.raw.flatMap { $0 }.firstIndex(of: char)
    if let index = index {
      let x = index % self.width
      let y = index / self.width
      return Coord(x: x, y: y)
    }
    return nil
  }

  func findAll(of char: Character) -> [Coord] {
    var coords = [Coord]()
    for i in 0..<height {
      for j in 0..<width {
        let current = Coord(x: j, y: i)
        if self[current] == char {
          coords.append(current)
        }
      }
    }
    return coords
  }
}
