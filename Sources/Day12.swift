import Algorithms

struct Field {
  var id: Character
  var area: Int = 1
  var perimeter: Int = 0
  var coords: [Coord] = [Coord]()

  func compute() -> Int {
    area * perimeter
  }

  mutating func visited(coord: Coord) {
    coords.append(coord)
  }
}
extension Field {
  init(id: Character) {
    self.id = id
    area = 1
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
    for neighbor in pos.crossNeighbors {
      print("checking for", neighbor)
      if let candidate = grid[neighbor] {
        if candidate == id {
          print("we are together")
          // same value means we have a new area tile
          return exploreField(from: neighbor, id: id, field: field)
        } else {
          print("someone else")
          // this is a frontier
          field.perimeter += 1
        }
      } else {
        print("grid boundary")
        // this is the frontier of the grid
        field.perimeter += 1
      }
    }
    return field
  }

  func part1() -> Int {

    var record = [Coord: Bool]()
    var fields = [Field]()
    for y in 0..<grid.height {
      for x in 0..<grid.width {
        let currentPos = Coord(x: x, y: y)
        print(currentPos)
        // position has already been visited
        guard record[currentPos] == nil else {
          print("already visited")
          continue
        }

        if let gridValue = grid[currentPos] {
          // start a new field
          print("starting a new field")
          let field = exploreField(
            from: currentPos, id: gridValue, field: Field(id: gridValue))
          fields.append(field)
          field.coords.forEach { s in
            record[s] = true
          }
          print("-------", field)
        }
      }
    }
    return fields.map { $0.compute() }.sum
  }

  func part2() -> Int {
    0
  }
}
