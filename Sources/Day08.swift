import Algorithms

struct Day08: AdventDay {
  var antennaLocations: [Character: [Coord]] = [Character: [Coord]]()
  var width: Int
  var height: Int

  init(data: String) {
    let lines = data.lines()
    height = lines.count
    width = lines[0].count
    for (colIdx, line) in lines.enumerated() {
      for (rowIdx, char) in line.enumerated() {
        if char != "." {
          let currentPos = Coord(x: rowIdx, y: colIdx)
          antennaLocations[char, default: [Coord]()].append(currentPos)
        }
      }
    }
  }

  func isInside(_ node: Coord) -> Bool {
    node.x >= 0 && node.x <= self.width - 1 && node.y >= 0 && node.y <= self.height - 1
  }

  func part1() -> Int {
    var antiNodes: Set<Coord> = Set()
    for (_, values) in antennaLocations {
      for pair in values.combinations(ofCount: 2) {
        let offset = pair[1] - pair[0]
        [
          pair[0] - offset,
          pair[1] + offset,
        ].filter { isInside($0) }.forEach {
          antiNodes.insert($0)
        }
      }
    }
    return antiNodes.count
  }

  func walkAntiNodes(antenna: Coord, offset: Coord) -> [Coord] {
    var allAntiNode = [Coord]()
    var nodePos = antenna
    repeat {
      allAntiNode.append(nodePos)
      nodePos += offset
    } while isInside(nodePos)
    return allAntiNode
  }

  func part2() -> Int {
    var antiNodes: Set<Coord> = Set()
    for (_, values) in antennaLocations {
      for pair in values.combinations(ofCount: 2) {
        let offset = pair[1] - pair[0]
        var localNodes = walkAntiNodes(antenna: pair[0], offset: offset * -1)
        localNodes.append(contentsOf: walkAntiNodes(antenna: pair[1], offset: offset))
        localNodes.forEach {
          antiNodes.insert($0)
        }
      }
    }
    return antiNodes.count
  }
}
