import Algorithms

struct Day03: AdventDay {
  var data: String

  func part1() -> Int {
    let search = /mul\((\d+),(\d+)\)/

    return data.ranges(of: search).map { match in
      let string = data[match].trimmingPrefix("mul(").trimmingCharacters(in: .punctuationCharacters)
      print(string)
      let numbers = string.split(
        separator: ","
      )
      print(numbers)
      return numbers.map {
        Int($0)
      }.compactMap {
        $0
      }.reduce(1, *)
    }.sum
  }

  func part2() -> Int {
    0
  }
}
