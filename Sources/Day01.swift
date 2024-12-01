import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var lines: [[Substring.SubSequence]] {
    data.split(separator: "\n").map { $0.split(separator: " ") }
  }

  var left: [Int] {
    lines.map { Int($0[0]) ?? 0 }.sorted()
  }

  var right: [Int] {
    lines.map { Int($0[1]) ?? 0 }.sorted()
  }

  // add here any computed values useful for the challenge

  func part1() -> Int {
    var sum = 0
    for (one, two) in zip(left, right) {
      sum += abs(one - two)
    }
    return sum
  }

  func part2() -> Int {
    var similarity = 0
    for elem in left {
      let occurrences = right.filter { $0 == elem }.count
      similarity += elem * occurrences
    }
    return similarity
  }
}
