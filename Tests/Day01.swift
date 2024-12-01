import Testing

@testable import aoc

@Suite("Day01")
struct Day01Tests {
  let testData = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day01(data: testData)
    #expect(challenge.part1() == 11)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day01(data: testData)
    #expect(challenge.part2() == 31)
  }
}
