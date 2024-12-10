import Algorithms

struct Calibration {
  var result: Int
  var values: [Int]
}
extension Calibration {
  init<S: StringProtocol>(from line: S) {
    let parts = line.split(separator: ":")
    result = Int(parts[0]) ?? 0
    values = parts[1].integers()
  }
}
extension Calibration: CustomStringConvertible {
  var description: String {
    "\(self.result): \(self.values.map {String($0)}.joined(separator: " "))"
  }
}

struct Day07: AdventDay {
  var calibrations: [Calibration]
  init(data: String) {
    calibrations = data.lines().map { Calibration(from: $0) }
  }

  func isValidCalibration(_ calibration: Calibration) -> Bool {
    // early return
    if calibration.values.count == 1 {
      return calibration.result == calibration.values[0]
    }
    // generate all operators permutations using a cartesian product method
    let allPermutations = product(["+", "*"], repeated: calibration.values.count - 1)
    for ops in allPermutations {
      var res = calibration.values[0]
      let products = zip(ops, calibration.values[1..<calibration.values.count])
      for (op, value) in products {
        if op == "+" {
          res += value
        }
        if op == "*" {
          res *= value
        }
      }
      if res == calibration.result {

        // early from the loop
        return true
      }
    }
    // none of the permutations allowed to get the expected result
    return false
  }

  func part1() -> Int {
    let possibleCalibrations = calibrations.filter {
      isValidCalibration($0)
    }

    return possibleCalibrations.map { $0.result }.sum
  }

  func isValidCalibration2(_ calibration: Calibration) -> Bool {
    // early return
    if calibration.values.count == 1 {
      return calibration.result == calibration.values[0]
    }
    // generate all operators permutations using a cartesian product method
    let allPermutations = product(["+", "*", "||"], repeated: calibration.values.count - 1)
    for ops in allPermutations {
      var res = calibration.values[0]
      let products = zip(ops, calibration.values[1..<calibration.values.count])
      for (op, value) in products {
        if op == "+" {
          res += value
        }
        if op == "*" {
          res *= value
        }
        if op == "||" {
          res = Int(String(res) + String(value)) ?? 0
        }
      }
      if res == calibration.result {
        // early from the loop
        return true
      }
    }
    // none of the permutations allowed to get the expected result
    return false
  }

  func part2() -> Int {
    let possibleCalibrations = calibrations.filter { calibration in
      if isValidCalibration(calibration) {
        return true
      } else {
        return isValidCalibration2(calibration)
      }
    }

    return possibleCalibrations.map { $0.result }.sum
  }
}
