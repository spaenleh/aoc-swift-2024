import Algorithms

enum Border: Hashable {
  case north(y: Int)
  case east(x: Int)
  case south(y: Int)
  case west(x: Int)

  static func create(direction: Int, coord: Coord) -> (Self, Int) {
    switch direction {
    case 0: (north(y: coord.y), coord.x)
    case 1: (east(x: coord.x), coord.y)
    case 2: (south(y: coord.y), coord.x)
    case 3: (west(x: coord.x), coord.y)
    default: (north(y: -1), -1)
    }
  }

  func toCardDirection() -> CardDirection {
    switch self {
    case .north: .north
    case .south: .south
    case .east: .east
    case .west: .west
    }
  }
}

enum CardDirection: Int, CustomStringConvertible {
  var description: String {
    switch self {
    case .north: "N"
    case .south: "S"
    case .east: "E"
    case .west: "W"
    }
  }
  case north = 0
  case east
  case south
  case west
}

struct Side: CustomStringConvertible {
  var description: String {
    "Side(\(direction)|\(border) \(values))"
  }
  var direction: CardDirection
  var border: Border
  var values: [Int]
}

struct Field {
  var id: Character
  var area: Int = 0
  var perimeter: Int = 0
  var coords: [Coord] = [Coord]()
  var sides: [Border: [Int]] = [Border: [Int]]()
  var sideCount: Int {
    let allSides = sides.map { (border, side) in
      let sortedSide = side.sorted()
      let diffs = zip(sortedSide, sortedSide.dropFirst()).map { $1 - $0 }
      let nbSides = diffs.filter { $0 > 1 }.count + 1
      return nbSides
    }
    return allSides.sum
  }

  mutating func addSide(idx: Int, pos: Coord) {
    let (border, otherAxis) = Border.create(direction: idx, coord: pos)
    sides[border, default: []].append(otherAxis)
  }

  func compute1() -> Int {
    area * perimeter
  }
  func compute2() -> Int {
    sideCount * area
  }

  mutating func visited(coord: Coord) {
    coords.append(coord)
  }
}
extension Field {
  init(id: Character) {
    self.id = id
    area = 0
    perimeter = 0
  }
}

struct Day12: AdventDay {
  var grid: Grid<Character>

  init(data: String) {
    grid = Grid(from: data)
  }

  func exploreField(from pos: Coord, id: Character, field oldField: Field) -> Field {
    var field = oldField
    field.visited(coord: pos)
    field.area += 1
    // explore the grid
    for (idx, neighbor) in pos.crossNeighbors.enumerated() {
      if field.coords.contains(neighbor) {
        continue
      }
      if let candidate = grid[neighbor] {
        if candidate == id {
          // same value means we have a new area tile
          field = exploreField(from: neighbor, id: id, field: field)
        } else {
          // this is a frontier
          field.perimeter += 1
          field.addSide(idx: idx, pos: neighbor)
        }
      } else {
        // this is the frontier of the grid
        field.perimeter += 1
        field.addSide(idx: idx, pos: neighbor)
      }
    }
    return field
  }

  func getFields() -> [Field] {
    var record = [Coord: Bool]()
    var fields = [Field]()
    for y in 0..<grid.height {
      for x in 0..<grid.width {
        let currentPos = Coord(x: x, y: y)
        // position has already been visited
        guard record[currentPos] == nil else {
          continue
        }
        if let gridValue = grid[currentPos] {
          // start a new field
          let field = exploreField(
            from: currentPos, id: gridValue, field: Field(id: gridValue))
          fields.append(field)
          field.coords.forEach { s in
            record[s] = true
          }
        }
      }
    }
    return fields
  }

  func part1() -> Int {
    return getFields().map { $0.compute1() }.sum
  }

  func part2() -> Int {
    return getFields().map { $0.compute2() }.sum
  }
}
