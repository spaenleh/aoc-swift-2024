struct Edge {
  var from: String
  var to: String
  var weight: Int
}
extension Edge {
  init(from: String, to: Int, weight: Int) {
    self.from = from
    self.to = String(to)
    self.weight = weight
  }
  init(from: Int, to: String, weight: Int) {
    self.from = String(from)
    self.to = to
    self.weight = weight
  }
  init(from: Int, to: Int, weight: Int) {
    self.from = String(from)
    self.to = String(to)
    self.weight = weight
  }

  static func inverted(edge: Edge) -> Self {
    Edge(from: edge.to, to: edge.from, weight: edge.weight)
  }
}

struct Maze {
  enum Tile: Character {
    case Wall = "#"
    case Floor = "."
  }
  enum Orientation {
    case vertical
    case horizontal
  }

  enum TileType {
    case DeadEnd  // cul de sac
    case Pipe(direction: Orientation)
    case Corner(quadrant: [Coord])
    case TSection
  }

  // map of the maze allowing access by coordinate
  private var positions: [Coord: Tile] = [Coord: Tile]()
  private var floor: [Coord: Int] = [Coord: Int]()
  private var width: Int
  private var height: Int
  private var startPosition: Coord = Coord.zero
  private var endPosition: Coord = Coord.zero

  init(from map: String) {
    let lines = map.lines()
    height = lines.count
    width = lines[0].count
    for (y, line) in lines.enumerated() {
      for (x, char) in line.enumerated() {
        let currentPos = Coord(x: x, y: y)
        let id = y * width + x
        if char == "S" {
          startPosition = currentPos
          continue
        }
        if char == "E" {
          endPosition = currentPos
          continue
        }
        let tile = Tile(rawValue: char)
        if let tile = tile, tile == .Floor {
          // print("floor", id)
          floor[currentPos] = id
        }
        positions[currentPos] = tile
      }
    }
  }

  func visitNext(node: String, cost: Int, edges: [Edge]) -> [Int] {
    var nCost = cost

    for candidate in edges.filter({ $0.from == node }) {
      if candidate.to == "E" {
        nCost += candidate.weight

      }
      let costs = visitNext(node: candidate.to, cost: cost, edges: edges)

    }
    return [Int]()
  }

  func findAllPathsToEnd() -> [Int] {
    var pos = startPosition
    var currentNode = "S"
    var allPaths = [Coord]()
    let edges = self.getNodes()
    let allEdges = edges.map { [$0, Edge.inverted(edge: $0)] }.flatMap { $0 }

    let costs = visitNext(node: "S", cost: 0, edges: allEdges)
    return costs
  }

  func getNodes() -> [Edge] {
    var edges = [Edge]()
    var intersects: Set<Int> = Set()
    for (coord, tileId) in floor {
      // for each tile define if we should add it to our node network
      let top = floor[coord + Coord.up]
      let left = floor[coord + Coord.left]
      let down = floor[coord + Coord.down]
      let right = floor[coord + Coord.right]

      if let top = top, let left = left, let right = right, let down = down {
        // add intersect so we do not create further edges
        // print("╬")
        intersects.insert(tileId)
        edges.append(Edge(from: top, to: right, weight: 1001))
        edges.append(Edge(from: top, to: left, weight: 1001))
        edges.append(Edge(from: down, to: right, weight: 1001))
        edges.append(Edge(from: down, to: left, weight: 1001))
        edges.append(Edge(from: right, to: left, weight: 2))
        edges.append(Edge(from: top, to: down, weight: 2))
        continue
      }
      if let top = top, let left = left, let down = down {
        // print("╣")
        intersects.insert(tileId)
        edges.append(Edge(from: top, to: left, weight: 1001))
        edges.append(Edge(from: down, to: left, weight: 1001))
        edges.append(Edge(from: top, to: down, weight: 2))
        continue
      }
      if let top = top, let right = right, let down = down {
        // print("╠")
        intersects.insert(tileId)
        edges.append(Edge(from: top, to: right, weight: 1001))
        edges.append(Edge(from: down, to: right, weight: 1001))
        edges.append(Edge(from: top, to: down, weight: 2))
        continue
      }
      if let top = top, let left = left, let right = right {
        // print("╩")
        intersects.insert(tileId)
        edges.append(Edge(from: top, to: right, weight: 1001))
        edges.append(Edge(from: top, to: left, weight: 1001))
        edges.append(Edge(from: left, to: right, weight: 2))
        continue
      }
      if let left = left, let right = right, let down = down {
        // print("╦")
        intersects.insert(tileId)
        edges.append(Edge(from: down, to: right, weight: 1001))
        edges.append(Edge(from: down, to: left, weight: 1001))
        edges.append(Edge(from: left, to: right, weight: 2))
        continue
      }
      if let top = top, let down = down {
        // print("║")
        if !intersects.contains(top) {
          edges.append(Edge(from: top, to: tileId, weight: 1))
        }
        if !intersects.contains(down) {
          edges.append(Edge(from: down, to: tileId, weight: 1))
        }
        continue
      }
      if let left = left, let right = right {
        // print("═")
        if !intersects.contains(left) {
          edges.append(Edge(from: left, to: tileId, weight: 1))
        }
        if !intersects.contains(right) {
          edges.append(Edge(from: right, to: tileId, weight: 1))
        }
        continue
      }
      if let top = top, let down = down {
        // print("║")
        if !intersects.contains(top) {
          edges.append(Edge(from: top, to: tileId, weight: 1))
        }
        if !intersects.contains(down) {
          edges.append(Edge(from: down, to: tileId, weight: 1))
        }
        continue
      }
      if let top = top, let left = left {
        // print("╝")
        intersects.insert(tileId)
        edges.append(Edge(from: top, to: left, weight: 1001))
        continue
      }
      if let left = left, let down = down {
        // print("╗")
        intersects.insert(tileId)
        edges.append(Edge(from: down, to: left, weight: 1001))
        continue
      }
      if let top = top, let right = right {
        // print("╚")
        intersects.insert(tileId)
        edges.append(Edge(from: top, to: right, weight: 1001))
        continue
      }
      if let right = right, let down = down {
        // print("╔")
        intersects.insert(tileId)
        edges.append(Edge(from: down, to: right, weight: 1001))
        continue
      }
    }
    // add Start and end
    let top = floor[startPosition + Coord.up]
    if let top = top {
      edges.append(Edge(from: "S", to: top, weight: 1001))
    }
    let right = floor[startPosition + Coord.right]
    if let right = right {
      edges.append(Edge(from: "S", to: right, weight: 1))
    }
    let down = floor[endPosition + Coord.down]
    if let down = down {
      edges.append(Edge(from: down, to: "E", weight: 1))
    }
    let left = floor[endPosition + Coord.left]
    if let left = left {
      edges.append(Edge(from: left, to: "E", weight: 1))
    }
    return edges
  }

  func getTileFor(coord: Coord) -> Character {
    let top = positions[coord + Coord.up]
    let left = positions[coord + Coord.left]
    let down = positions[coord + Coord.down]
    let right = positions[coord + Coord.right]
    if let current = positions[coord], current == .Floor {
      return " "
    }
    return switch (top, left, right, down) {
    case let (top, left, right, down)
    where top == .Wall && down == .Wall && left == .Wall && right == .Wall:
      "╬"
    case let (top, left, _, down) where top == .Wall && down == .Wall && left == .Wall: "╣"
    case let (top, _, right, down) where top == .Wall && down == .Wall && right == .Wall: "╠"
    case let (top, left, right, _) where top == .Wall && left == .Wall && right == .Wall: "╩"
    case let (_, left, right, down) where down == .Wall && left == .Wall && right == .Wall: "╦"
    case let (top, _, _, down) where top == .Wall && down == .Wall: "║"
    case let (_, left, right, _) where left == .Wall && right == .Wall: "═"
    case let (top, left, _, _) where left == .Wall && top == .Wall: "╝"
    case let (_, left, _, down) where left == .Wall && down == .Wall: "╗"
    case let (top, _, right, _) where top == .Wall && right == .Wall: "╚"
    case let (_, _, right, down) where down == .Wall && right == .Wall: "╔"
    case let (_, left, right, _) where left == .Wall || right == .Wall: "═"
    case let (top, _, _, down) where top == .Wall || down == .Wall: "║"
    default: "o"
    }
  }

  func display() -> String {
    var lines = [String]()
    for y in 0..<height {
      var line = [Character]()
      for x in 0..<width {
        let currentPos = Coord(x: x, y: y)
        if currentPos == startPosition {
          line.append("S")
          continue
        }
        if currentPos == endPosition {
          line.append("E")
          continue
        }
        let tile = getTileFor(coord: currentPos)
        line.append(tile)
      }
      lines.append(String(line))
    }
    return lines.joined(separator: "\n")
  }
}
