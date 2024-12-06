import Algorithms

enum Direction: Int {
  case North = 0
  case East, South, West

  func heading() -> Coord {
    Coord.cross[rawValue]
  }

  static func fromHeading(coord: Coord) -> Self {
    Self(rawValue: Coord.cross.firstIndex { $0 == coord } ?? 0) ?? .North
  }

  func makeTurn() -> Self {
    Self(rawValue: self.rawValue + 1 % 4) ?? .North
  }

}

struct Guard {
  var pos: Coord
  var direction: Direction

  func nextPost() -> Coord {
    self.pos + self.direction.heading()
  }
}

struct Day06: AdventDay {
  var grid: Grid
  init(data: String) {
    grid = Grid(from: data)
  }

  func guardPatrol() -> (locations: Set<Coord>, steps: [Coord], obstacles: [Coord]) {
    var locations: Set<Coord> = Set()
    var steps: [Coord] = [Coord]()
    var obstacles: [Coord] = [Coord]()
    var officer = Guard(pos: grid.firstCoord(of: "^")!, direction: .North)
    while officer.pos.isInside(grid: grid) {
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

  func doesComeBack(step: Coord) -> Bool {
    var officer = Guard(pos: grid.firstCoord(of: "^")!, direction: .North)
    var locations: [Coord] = [Coord]()
    while officer.pos.isInside(grid: grid) {
      locations.append(officer.pos)

      // move the guard
      let nextPos = officer.pos + officer.direction.heading()
      // behave like there is a real obstacle
      if nextPos == step {
        officer.direction = officer.direction.makeTurn()
      } else {

        if !grid.includes(coord: nextPos) {
          return false
        }
        if grid[nextPos] == "#" {
          // guard is blocked
          officer.direction = officer.direction.makeTurn()
        }
      }
      // check if we are going over our steps
      if locations.contains([officer.pos, nextPos]) {
        return true
      }
      // move officer one step
      officer.pos = officer.pos + officer.direction.heading()
    }
    return false
  }

  func part1() -> Int {
    guardPatrol().locations.count
  }

  // func part2() -> Int {
  //   var potentialObstacles: [Coord] = [Coord]()
  //   for step in Set(guardPatrol().steps) {
  //     if doesComeBack(step: step) {
  //       potentialObstacles.append(step)
  //     }
  //   }
  //   return Set(potentialObstacles).count
  // }

  func isAValidLoop(wrappedOffset: Int, c: [Coord]) -> Coord? {
    if wrappedOffset == 0 {
      if c[c.startIndex].x > c[c.endIndex - 1].x {
        let coord = Coord(x: c[c.startIndex].x - 1, y: c[c.endIndex - 1].y)
        print("yes 0", coord)
        return coord
      }
    }
    if wrappedOffset == 1 {
      if c[c.startIndex].y > c[c.endIndex - 1].y {
        let coord = Coord(x: c[c.startIndex].x, y: c[c.startIndex].y - 1)
        print("yes 1", coord)
        return coord
      }
    }
    if wrappedOffset == 2 {

      if c[c.startIndex].x < c[c.endIndex - 1].x {
        let coord = Coord(x: c[c.endIndex - 1].x + 1, y: c[c.startIndex].y)
        print("yes 2", coord)
        return coord
      }
    }
    if wrappedOffset == 3 {
      if c[c.startIndex].y < c[c.endIndex - 1].y {
        let coord = Coord(x: c[c.endIndex - 1].x, y: c[c.startIndex].y + 1)
        print("yes 3", coord)
        return coord
      }
    }
    return nil
  }

  func part2() -> Int {
    var count = 0
    let obstacles = guardPatrol().obstacles

    var newObstacles: [Coord] = [Coord]()
    for (offset, candidates) in obstacles.windows(ofCount: 4).enumerated() {
      var c = Array(candidates)
      let wrappedOffset = offset % 4
      if let coord = isAValidLoop(wrappedOffset: wrappedOffset, c: c) {
        count += 1
        newObstacles.append(coord)
      }
      if offset > 4 {

        // TODO: this is not right
        for (idx, elem) in obstacles[0...0].enumerated() {
          print("trying", idx, elem)
          let wrappedOffset = offset % 4
          c[3] = elem
          if let coord = isAValidLoop(wrappedOffset: wrappedOffset, c: c) {
            count += 1
            newObstacles.append(coord)
            print(c)
          }
        }

      }
    }
    print(newObstacles)

    // 115 -> too low
    return count
  }
}
