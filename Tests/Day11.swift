import Testing

@testable import aoc

@Suite("Day11")
struct Day11Tests {

  let testData = """
    125 17
    """

  @Test("Get stones")
  func testGetStones() async throws {
    #expect(Day11.getStones(data: testData) == [125: 1, 17: 1])
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day11(
      data: testData
    )
    #expect(challenge.part1() == 55312)
  }

}
