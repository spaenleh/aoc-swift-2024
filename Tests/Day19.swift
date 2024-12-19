import Testing

@testable import aoc

@Suite("Day19")
struct Day19Tests {
  let testData = """
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day19(data: testData)
    #expect(try challenge.part1() == 6)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day19(data: testData)
    #expect(challenge.part2() == 0)
  }
}
