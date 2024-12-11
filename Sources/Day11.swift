import Algorithms

struct Day11: AdventDay {
  var data: String

  static func getStones(data: String) -> [Int: Int] {
    var stones = [Int: Int]()
    data.trimmed().integers().forEach { stone in
      stones[stone, default: 0] += 1
    }
    return stones
  }

  func stoneMe(blinks: Int) -> Int {
    var stones = Self.getStones(data: data)
    for _ in 0..<blinks {
      var newStones = [Int: Int]()
      for (stone, count) in stones {
        // 0 becomes 1
        if stone == 0 {
          newStones[1, default: 0] += count
          continue
        }
        // even numbers are split in 2 stones
        if String(stone).count % 2 == 0 {
          // print("is even", String(stone).count)
          let stoneString = String(stone)
          let first = Int(stoneString.prefix(stoneString.count / 2)) ?? 0
          let last = Int(stoneString.suffix(stoneString.count / 2)) ?? 0
          newStones[first, default: 0] += count
          newStones[last, default: 0] += count
          continue
        }
        // any other multiply by 2024
        newStones[stone * 2024, default: 0] += count
      }
      // set the stones for the next iteration
      stones = newStones
    }
    // compute the total number of stones
    return stones.values.reduce(0, +)
  }

  func part1() -> Int {
    stoneMe(blinks: 25)
  }

  func part2() -> Int {
    stoneMe(blinks: 75)
  }
}
