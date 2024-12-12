import Algorithms

struct Day10: AdventDay {
  var grid: Grid<Character>

  init(data: String) {
    grid = Grid(from: data)
  }

  func findNextStep(for startChar: String, at: Coord, summits: [Coord]) -> [Coord] {
    var results = summits
    if startChar == "9" {
      results.append(at)
      return results
    }
    let nextChar = String((Int(startChar) ?? 0) + 1)
    for neighbor in at.crossNeighbors {
      if let candidate = grid[neighbor], String(candidate) == nextChar {
        let res = findNextStep(for: nextChar, at: neighbor, summits: summits)
        results.append(contentsOf: res)
      } else {
      }
    }
    return results
  }

  func part1() -> Int {
    grid.findAll(of: "0").map {
      Set(findNextStep(for: "0", at: $0, summits: [Coord]())).count
    }.sum
  }

  func part2() -> Int {
    grid.findAll(of: "0").map {
      findNextStep(for: "0", at: $0, summits: [Coord]()).count
    }.sum
  }
}
