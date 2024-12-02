import Testing

@testable import aoc

@Suite("Day03")
struct Day03Tests {
  let testData = """

    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day03(data: testData)
    #expect(challenge.part1() == 0)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day03(data: testData)
    #expect(challenge.part2() == 0)
  }
}
