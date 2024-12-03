import Algorithms
import Foundation

extension StringProtocol {
  func trimmed() -> String {
    self.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  func concatLines() -> String {
    self.replacingOccurrences(of: "\n", with: "")
  }

  func lines() -> [SubSequence] {
    self.split(separator: "\n")
  }

  func integers(separator: String = " ") -> [Int] {
    self.split(separator: separator).map { Int($0) }.compactMap { $0 }
  }

  func doubles(separator: String = " ") -> [Double] {
    self.split(separator: separator).map { Double($0) }.compactMap { $0 }
  }
}
