import Algorithms

struct Day03: AdventDay {
  var data: String

  /// computes the operations from a corrupter memory dump
  func compute(data input: String) -> Int {
    input.ranges(of: /mul\(\d+,\d+\)/).map { match in
      input[match].trimmingPrefix("mul(").trimmingCharacters(in: .punctuationCharacters)
        .split(
          separator: ","
        )
        .map {
          Int($0)
        }.compactMap {
          $0
        }.reduce(1, *)
    }.sum
  }

  func part1() -> Int {
    compute(data: data)
  }

  func part2() -> Int {
    let singleLine = data.replacingOccurrences(of: "\n", with: "")

    /// remove anything that is between a "don't()" and a "do()"
    /// be careful to match as few characters as possible with `.*?`
    let newData = singleLine.replacing(
      /(don't\(\).*?do\(\))/, with: "")

    return compute(data: newData)
  }
}
