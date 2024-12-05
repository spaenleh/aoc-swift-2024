import Algorithms

struct Rule {
  var before: Int
  var after: Int

}
extension Rule {
  init(data: Substring) {
    let parts = data.split(separator: "|")
    before = Int(parts[0]) ?? 0
    after = Int(parts[1]) ?? 0
  }
}

struct Day05: AdventDay {
  var rules: [Int: [Int]]
  var updates: [[Int]]

  init(data: String) {
    let parts = data.split(separator: "\n\n")
    rules = [Int: [Int]]()
    for line in parts[0].lines() {
      let parts = line.split(separator: "|")
      let before = Int(parts[0]) ?? 0
      let after = Int(parts[1]) ?? 0
      rules[after, default: [Int]()].append(before)
    }
    updates = parts[1].lines().map { $0.integers(separator: ",") }
  }

  func part1() -> Int {
    updates.filter { update in
      for (idx, page) in update.enumerated() {
        let rulesForPage = rules[page, default: [Int]()]
        let brokenRules = rulesForPage.map { update[idx + 1..<update.count].contains($0) }.count {
          $0 == true
        }
        if brokenRules > 0 {
          return false
        }
      }
      return true
    }.map { update in update[update.count / 2] }.sum
  }

  func part2() -> Int {
    0
  }
}
