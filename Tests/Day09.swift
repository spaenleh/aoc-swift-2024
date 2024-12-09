import Testing

@testable import aoc

@Suite("Day09")
struct Day09Tests {
  let testData = """
    2333133121414131402
    """

  @Test("simple part")
  func testSimplePart1() async throws {
    #expect(Day09(data: "1234").part1() == 6)
    #expect(Day09(data: "12345").part1() == 60)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day09(data: testData)
    #expect(challenge.part1() == 1928)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day09(data: testData)
    #expect(challenge.part2() == 2858)
  }
}
