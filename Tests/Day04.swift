import Testing

@testable import aoc

@Suite("Day04")
struct Day04Tests {
  let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

  @Test("Neighbor search")
  func testNeighborSearch() async throws {
    let grid = Grid(
      from: """
        XMAS
        XMAS
        XMAS
        XMAS
        """)
    #expect(
      searchInNeighbors(pos: Coord(x: 0, y: 0), grid) == [Coord(x: 1, y: 1), Coord(x: 1, y: 0)])
  }

  @Test("part1 simple")
  func testSimplePart1() async throws {
    let grid = """
      XMAS
      XMAS
      XMAS
      XMAS
      """
    let challenge = Day04(data: grid)
    #expect(challenge.part1() == 6)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day04(data: testData)
    #expect(challenge.part1() == 18)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day04(data: testData)
    #expect(challenge.part2() == 9)
  }
}
