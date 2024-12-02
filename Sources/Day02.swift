import Algorithms

struct Report {
  var value: [Int]
}
extension Report {
  init(_ data: Substring) {
    value = data.split(separator: " ").map { v in Int(v) ?? 0 }
  }
}

func spreadsWell(_ value: Int) -> Bool {
  abs(value) <= 3 && abs(value) >= 1
}

func getPermutationsExcludingOneElement(_ arr: [Int]) -> [[Int]] {
  var perms = [[Int]]()
  for idx in 0..<arr.count {
    var copiedArr = arr
    let _ = copiedArr.remove(at: idx)
    perms.append(copiedArr)
  }
  return perms
}

struct ReportAnalyzer {

  func isSafe(report: Report, damped: Bool = false) -> Bool {
    // all values are either increasing or decreasing
    let diffs = report.value.adjacentPairs().map { (one, two) in
      two - one
    }
    let order = diffs.grouped { v in
      if v < 0 {
        return "desc"
      }
      if v > 0 {
        return "asc"
      }
      return "none"
    }
    let spread = diffs.filter { spreadsWell($0) }

    let isSafe = order.count == 1 && spread.count == diffs.count
    if damped && !isSafe {
      let reportPermutations = getPermutationsExcludingOneElement(report.value)
      let isAnySafe =
        reportPermutations.map {
          return ReportAnalyzer().isSafe(report: Report(value: Array($0)))
        }.filter { $0 }.count >= 1
      return isAnySafe
    }
    return isSafe
  }
}

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var reports: [Report] {
    data.split(separator: "\n").map { Report($0) }
  }

  func part1() -> Int {
    reports.map { ReportAnalyzer().isSafe(report: $0) }.filter { $0 }.count
  }

  func part2() -> Int {
    reports.map { ReportAnalyzer().isSafe(report: $0, damped: true) }.filter { $0 }.count
  }
}
