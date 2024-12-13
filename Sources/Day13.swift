import Algorithms

struct ClawPlay {
  var xA: Int = 0
  var yA: Int = 0
  var xB: Int = 0
  var yB: Int = 0
  var X: Int = 0
  var Y: Int = 0

  func computeTokens(a: Int, b: Int) -> Int {
    return 3 * a + b
  }

  func getValues(x: Int, y: Int, maxClicks: Int? = nil) -> Int? {
    let top = (y * xA) - (x * yA)
    let bottom = (yB * xA) - (xB * yA)
    if top % bottom == 0 {
      let b = top / bottom
      let a = (x - (b * xB)) / xA

      if let bound = maxClicks {
        if a <= bound && b <= bound {
          return computeTokens(a: a, b: b)
        }
      } else {
        return computeTokens(a: a, b: b)
      }
    }
    return nil
  }

  func win(isTwo: Bool = false) -> Int? {
    if isTwo {
      return getValues(x: X + 10_000_000_000_000, y: Y + 10_000_000_000_000)
    }
    return getValues(x: X, y: Y, maxClicks: 100)
  }
}

extension ClawPlay {
  init(values v: [Int]) {
    xA = v[0]
    yA = v[1]
    xB = v[2]
    yB = v[3]
    X = v[4]
    Y = v[5]
  }
}

func parseBlock(data: Substring) -> ClawPlay? {
  if let parts =
    data.firstMatch(
      of: /Button A: X\+(\d+), Y\+(\d+)\nButton B: X\+(\d+), Y\+(\d+)\nPrize: X=(\d+), Y=(\d+)/)
  {
    let values = [parts.1, parts.2, parts.3, parts.4, parts.5, parts.6].map { Int($0) ?? 0 }
    return ClawPlay(values: values)
  }
  return nil
}

struct Day13: AdventDay {
  var plays: [ClawPlay]

  init(data: String) {
    plays = data.split(separator: "\n\n").map { block in
      parseBlock(data: block)
    }.compactMap { $0 }
  }

  func part1() -> Int {
    return plays.map { $0.win() }.compactMap { $0 }.sum
  }

  func part2() -> Int {
    return plays.map { $0.win(isTwo: true) }.compactMap { $0 }.sum
  }
}
