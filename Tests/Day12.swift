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

  @Test("first")
  func testFirst() async throws {
    let challenge = Day12(
      data: """
        AAAA
        BBCD
        BBCC
        EEEC
        """)
    #expect(challenge.part1() == 140)
  }

  @Test("second")
  func testSecond() async throws {
    let challenge = Day12(
      data: """
        OOOOO
        OXOXO
        OOOOO
        OXOXO
        OOOOO
        """)
    #expect(challenge.part1() == 772)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day12(data: testData)
    #expect(challenge.part1() == 1930)
  }

  @Test("simple2")
  func testSimple2() async throws {
    #expect(
      Day12(
        data: """
          AAAA
          BBCD
          BBCC
          EEEC
          """
      ).part2() == 80)
    print("------")
    #expect(
      Day12(
        data: """
          EEEEE
          EXXXX
          EEEEE
          EXXXX
          EEEEE
          """
      ).part2() == 236)
    #expect(
      Day12(
        data: """
          AAAAAA
          AAABBA
          AAABBA
          ABBAAA
          ABBAAA
          AAAAAA
          """
      ).part2() == 236)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day12(data: testData)
    #expect(challenge.part2() == 1206)
  }
}
