import Algorithms

func searchInNeighbors(pos: Coord, _ grid: Grid<Character>) -> [Coord] {
  grid.filter(allInside: pos.fullNeighbors).filter { n in
    grid[n] == "M"
  }
}

func isMAS(pos: Coord, _ grid: Grid<Character>) -> Bool {
  let candidates = pos.cornerNeighbors
  if grid.filter(allInside: candidates).count == 4 {
    let l = candidates.map { grid[$0] }.compactMap { $0 }
    let letterSet = Set(l)
    // same letter can not be on opposite side
    return l[0] != l[2] && l[1] != l[3] && letterSet.count == 2 && letterSet == ["M", "S"]
  }
  return false
}

func isWhole(pos: Coord, inDir: Coord, grid: Grid<Character>) -> Bool {
  let aPos = pos + inDir
  let sPos = aPos + inDir
  if let aValue = grid[aPos], let sValue = grid[sPos] {
    return aValue == "A" && sValue == "S"
  }
  return false
}

struct Day04: AdventDay {
  var grid: Grid<Character>
  init(data: String) {
    grid = Grid(from: data)
  }

  func countAllWhere(letter search: Character, predicate: (Coord, Grid<Character>) -> Bool) -> Int {
    grid.raw.enumerated().map { (y, line) in
      line.enumerated().map { (x, letter) in
        if letter == search {
          return predicate(Coord(x: x, y: y), grid)
        }
        return false
      }
    }.flatMap { $0 }.count { $0 == true }
  }

  func part1() -> Int {
    var count = 0
    // get all positions of "X"
    for (y, line) in grid.raw.enumerated() {
      for (x, letter) in line.enumerated() {
        if letter == "X" {
          let currentPos = Coord(x: x, y: y)
          let results = searchInNeighbors(pos: currentPos, grid)
          if results.count > 0 {
            for candidate in results {
              let inDir = candidate - currentPos
              if isWhole(pos: candidate, inDir: inDir, grid: grid) {
                count += 1
              }
            }
          }
        }
      }
    }
    return count
  }

  func part2() -> Int {
    countAllWhere(letter: "A", predicate: isMAS)
  }
}
