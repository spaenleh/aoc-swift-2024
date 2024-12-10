import Testing

@testable import aoc

@Suite("Day10")
struct Day10Tests {
  let testData = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day10(data: testData)
    #expect(challenge.part1() == 36)
  }

  @Test("simple")
  func testSimple() async throws {
    #expect(
      Day10(
        data: """
          0123
          1234
          8765
          9876
          """
      ).part1() == 1)
    #expect(
      Day10(
        data: """
          9990999
          9991999
          9992999
          6543456
          7999997
          8599958
          9999999
          """
      ).part1() == 2)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day10(data: testData)
    #expect(challenge.part2() == 81)
  }
}
