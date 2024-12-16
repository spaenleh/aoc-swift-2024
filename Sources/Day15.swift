import Algorithms

enum Instruction: Character {
  case Up = "^"
  case Down = "v"
  case Left = "<"
  case Right = ">"

  func toCoordOffset() -> Coord {
    switch self {
    case .Up: Coord.up
    case .Down: Coord.down
    case .Left: Coord.left
    case .Right: Coord.right
    }
  }
}

enum Object: Character {
  case Wall = "#"
  case Box = "O"
  case Air = "."
  case Robot = "@"
}

struct Warehouse {
  enum WarehouseError: Error {
    case RobotPosition(message: String)
  }
  // TODO: can we have a subset of the cases of object in here ? remove .Air
  var map = [Coord: Object]()

  mutating func register(good: Object?, at location: Coord) {
    // we do not want to register air and good needs to be defined
    if let good = good, good != .Air {
      map[location] = good
    }
  }

  private func getRobot() throws -> (key: Coord, value: Object) {
    guard let robotIndex = map.firstIndex(where: { (_, value) in value == .Robot }) else {
      throw WarehouseError.RobotPosition(message: "Robot could not be found")
    }
    return map[robotIndex]
  }

  private mutating func moveRobot(to position: Coord) throws {
    guard let robotIndex = map.firstIndex(where: { (_, value) in value == .Robot }) else {
      throw WarehouseError.RobotPosition(message: "Robot could not be found")
    }
    map.remove(at: robotIndex)
    map[position] = .Robot
  }

  private mutating func teleportBox(from initialPos: Coord, to targetPos: Coord) {
    map.removeValue(forKey: initialPos)
    map[targetPos] = .Box
  }

  func display() -> String {
    let maxX = map.keys.map { $0.x }.max() ?? 0
    let maxY = map.keys.map { $0.y }.max() ?? 0
    var grid = [[Character]]()
    for y in 0...maxY {
      var line = [Character]()
      for x in 0...maxX {
        if let elem = map[Coord(x: x, y: y)] {
          line.append(elem.rawValue)
        } else {
          line.append(".")
        }
      }
      grid.append(line)
    }
    return grid.map { String($0) }.joined(separator: "\n")
  }

  mutating func execute(instruction: Instruction) {
    let robotPos = try! getRobot().key
    let moveDir = instruction.toCoordOffset()
    let nextRobotPos = robotPos + moveDir
    // what is at that next position ?
    if let nextPosObject = map[nextRobotPos] {
      switch nextPosObject {
      case .Wall: break  // should not go into walls, what is this harry potter ?
      case .Robot: break  // should not happen
      case .Air: break  // we do not keep Air
      case .Box:
        // check if there is an empty spot behind
        var nextBoxPos = nextRobotPos
        var objectAtNext: Object? = nextPosObject
        while objectAtNext == .Box {
          nextBoxPos += moveDir
          objectAtNext = map[nextBoxPos]
        }
        if objectAtNext == nil {
          // available spot is `nextBoxPos`
          teleportBox(from: nextRobotPos, to: nextBoxPos)
          try! moveRobot(to: nextRobotPos)
          // print("robot has moved and box was teleported")
        } else {
          // print("encountered a wall, do nothing")
        }
      }
    } else {
      // nothing we can move safely
      try! moveRobot(to: nextRobotPos)
    }
  }

  func gpsSum() -> Int {
    map.filter { $0.value == .Box }.map { $0.key.x + 100 * $0.key.y }.sum
  }
}

struct Day15: AdventDay {
  var instructions: [Instruction]
  var rawMap: Substring

  init(data: String) {
    let parts = data.split(separator: "\n\n")
    rawMap = parts[0]

    instructions = parts[1].replacingOccurrences(of: "\n", with: "").map {
      Instruction(rawValue: $0)
    }.compactMap { $0 }
  }

  func parseMap() -> Warehouse {
    var warehouse = Warehouse()
    for (y, line) in rawMap.lines().enumerated() {
      for (x, elem) in line.enumerated() {
        warehouse.register(good: Object(rawValue: elem), at: Coord(x: x, y: y))
      }
    }
    return warehouse
  }

  func part1() -> Int {
    var wareHouse = parseMap()
    // print(wareHouse.display())
    for (_, instruction) in instructions.enumerated() {
      // print("step \(idx), \(instruction.rawValue):\n")
      wareHouse.execute(instruction: instruction)
      // print(wareHouse.display())
    }
    let score = wareHouse.gpsSum()
    return score
  }

  func part2() -> Int {
    0
  }
}
