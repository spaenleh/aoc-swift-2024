import Algorithms

enum Direction: Int {
  case North = 0
  case East, South, West

  func heading() -> Coord {
    if Coord.cross.indices.contains(rawValue) {
      return Coord.cross[rawValue]
    }
    fatalError()
  }

  static func fromHeading(coord: Coord) -> Self {
    Self(rawValue: Coord.cross.firstIndex { $0 == coord } ?? 0) ?? .North
  }

  func makeTurn() -> Self {
    Self(rawValue: self.rawValue + 1 % 4) ?? .North
  }

}

struct Guard: Hashable {
  var pos: Coord
  var direction: Direction

  func nextPost() -> Coord {
    self.pos + self.direction.heading()
  }
}

struct Day06: AdventDay {
  var grid: Grid<Character>
  init(data: String) {
    grid = Grid(from: data)
  }

  func guardPatrol() -> (locations: Set<Coord>, steps: [Coord], obstacles: [Coord]) {
    var locations: Set<Coord> = Set()
    var steps: [Coord] = [Coord]()
    var obstacles: [Coord] = [Coord]()
    var officer = Guard(pos: grid.firstCoord(of: "^")!, direction: .North)
    while grid.includes(coord: officer.pos) {
      // save position
      locations.insert(officer.pos)

      // move the guard
      let nextPos = officer.pos + officer.direction.heading()
      if !grid.includes(coord: nextPos) {
        obstacles.append(nextPos)
        steps.append(nextPos)
        break
      }
      if grid[nextPos] == "#" {
        obstacles.append(nextPos)
        // guard is blocked
        officer.direction = officer.direction.makeTurn()
      }
      // move officer one step
      officer.pos = officer.pos + officer.direction.heading()
      steps.append(officer.pos)
    }
    return (locations, steps, obstacles)
  }

  func doesComeBack(step: Coord, path: [Coord].SubSequence, grid newGrid: Grid<Character>) -> Bool {
    guard let officerPos = newGrid.firstCoord(of: "^") else {
      return false
    }
    var officer = Guard(pos: officerPos, direction: .North)
    var locations: [Guard] = [Guard]()
    while newGrid.includes(coord: officer.pos) {
      // check if we are going over our steps
      if locations.contains(officer) {
        return true
      }
      locations.append(officer)

      // move the guard
      let nextPos = officer.pos + officer.direction.heading()

      if !newGrid.includes(coord: nextPos) {
        return false
      }
      if let nextChar = newGrid[nextPos], nextChar == "#" {
        // guard is blocked
        officer.direction = officer.direction.makeTurn()
      }
      // move officer one step
      officer.pos = officer.pos + officer.direction.heading()
    }
    return false
  }

  func part1() -> Int {
    guardPatrol().locations.count
  }

  func isAValidLoop(wrappedOffset: Int, c: [Coord]) -> Coord? {
    if wrappedOffset == 0 {
      if c[c.startIndex].x > c[c.endIndex - 1].x {
        let coord = Coord(x: c[c.startIndex].x - 1, y: c[c.endIndex - 1].y)
        return coord
      }
    }
    if wrappedOffset == 1 {
      if c[c.startIndex].y > c[c.endIndex - 1].y {
        let coord = Coord(x: c[c.startIndex].x, y: c[c.startIndex].y - 1)
        return coord
      }
    }
    if wrappedOffset == 2 {

      if c[c.startIndex].x < c[c.endIndex - 1].x {
        let coord = Coord(x: c[c.endIndex - 1].x + 1, y: c[c.startIndex].y)
        return coord
      }
    }
    if wrappedOffset == 3 {
      if c[c.startIndex].y < c[c.endIndex - 1].y {
        let coord = Coord(x: c[c.endIndex - 1].x, y: c[c.startIndex].y + 1)
        return coord
      }
    }
    return nil
  }

  func part2() -> Int {

    let (_, steps, _) = guardPatrol()
    var count = 0
    let newSteps = steps.dropFirst()
    for (stepIdx, step) in newSteps.enumerated() {
      var newGrid = grid
      if newGrid.includes(coord: step) {
        newGrid.raw[step.y][step.x] = "#"
        if doesComeBack(step: step, path: newSteps[0..<stepIdx], grid: newGrid) {
          count += 1
          print("found a loop at", step)
        }
      }
    }
    // 125 -> too low
    // 200 -> too low
    // 115 -> too low
    // 1713 -> not the right answer

    return count
  }
}
