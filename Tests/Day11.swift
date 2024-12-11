import Testing

@testable import aoc

@Suite("Day11")
struct Day11Tests {

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day11(
      data: """
        125 17
        """
    )
    #expect(challenge.part1() == 55312)
  }

}
