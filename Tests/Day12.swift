import Testing

@testable import aoc

@Suite("Day12")
struct Day12Tests {
  let testData = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day12(data: testData)
    #expect(challenge.part1() == 1930)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day12(data: testData)
    #expect(challenge.part2() == 0)
  }
}
