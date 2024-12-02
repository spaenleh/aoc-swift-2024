import Algorithms

struct Day01: AdventDay {
  var data: String

  var lines: [[Int]] {
    data.lines().map { $0.integers() }
  }

  var left: [Int] {
    lines.map { $0[0] }.sorted()
  }

  var right: [Int] {
    lines.map { $0[1] }.sorted()
  }

  func part1() -> Int {
    zip(left, right).map { l, r in abs(l - r) }.sum
  }

  func part2() -> Int {
    left.map { elem in
      elem * right.filter { $0 == elem }.count
    }.sum
  }
}
