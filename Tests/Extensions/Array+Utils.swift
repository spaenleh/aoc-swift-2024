import Testing

@testable import aoc

@Suite("Array extensions")
struct ArrayExtensions {
  @Test("Sum")
  func testSum() async throws {
    #expect([1, 2, 3, 4, 5, 6].sum == 21)
    #expect([].sum == 0)
    #expect([].sum == 0)
  }

}
