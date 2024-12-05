import Algorithms

struct Day05: AdventDay {
  var rules: [Int: [Int]]
  var updates: [[Int]]

  func middlePage(_ update: [Int]) -> Int {
    update[update.count / 2]
  }

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

  func isCorrect(_ update: [Int]) -> Bool {
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
  }

  func part1() -> Int {
    updates.filter { isCorrect($0) }.map { middlePage($0) }.sum
  }

  func fixOrder(_ update: [Int]) -> [Int] {
    var fixedUpdate = update
    for (idx, page) in update.enumerated() {
      let rulesForPage = rules[page, default: [Int]()]
      let brokenRules = rulesForPage.map { update[idx + 1..<update.count].contains($0) }
      for (isBroken, infringingPage) in zip(brokenRules, rulesForPage) {
        if isBroken {
          if let infringingIndex = fixedUpdate.firstIndex(of: infringingPage) {
            let value = fixedUpdate.remove(at: infringingIndex)
            fixedUpdate.insert(value, at: idx)
          }
        }
      }
    }
    if !isCorrect(fixedUpdate) {
      fixedUpdate = fixOrder(fixedUpdate)
    }
    return fixedUpdate
  }

  func part2() -> Int {
    updates.filter { !isCorrect($0) }.map { middlePage(fixOrder($0)) }.sum
  }
}
