import Algorithms

func getPermutationsExcludingOneElement(_ arr: [Int]) -> [[Int]] {
  var perms = [[Int]]()
  for idx in 0..<arr.count {
    var copiedArr = arr
    let _ = copiedArr.remove(at: idx)
    perms.append(copiedArr)
  }
  return perms
}

func isSafe(_ report: [Int], damped: Bool = false) -> Bool {
  // all values are either increasing or decreasing
  let diffs = report.adjacentPairs().map { $1 - $0 }
  let order = diffs.grouped { v in
    if v < 0 {
      return "desc"
    }
    if v > 0 {
      return "asc"
    }
    return "none"
  }
  // compute the differences
  let acceptableDifferences = diffs.filter { abs($0) <= 3 && abs($0) >= 1 }
  let isReportSafe = order.count == 1 && acceptableDifferences.count == diffs.count

  if damped && !isReportSafe {
    let reportPermutations = getPermutationsExcludingOneElement(report)
    let isAnySafe =
      reportPermutations.map {
        return isSafe($0)
      }.filter { $0 }.count >= 1
    return isAnySafe
  }
  return isReportSafe
}

struct Day02: AdventDay {
  var data: String

  var reports: [[Int]] {
    data.lines().map { $0.integers() }
  }

  func part1() -> Int {
    reports.map { isSafe($0) }.count(where: { $0 == true })
  }

  func part2() -> Int {
    reports.map { isSafe($0, damped: true) }.count { $0 == true }
  }
}
