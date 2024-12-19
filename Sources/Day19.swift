import Algorithms

struct Day19: AdventDay {
  var data: String

  func part1() throws -> Int {
    let parts = data.trimmed().split(separator: "\n\n")
    let words =
      "^(\(parts[0].split(separator: ",").map { "(\($0.trimmed()))" }.joined(separator: "|")))*$"
    let regex = try Regex(words)

    var count = 0
    for design in parts[1].lines() {
      if (try? regex.wholeMatch(in: design)) != nil {
        count += 1
      }
    }
    return count
  }

  func part2() -> Int {
    0
  }
}
