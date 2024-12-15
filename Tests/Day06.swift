import Testing

@testable import aoc

@Suite("Day06")
struct Day06Tests {
  let testData = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day06(data: testData)
    #expect(challenge.part1() == 41)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day06(data: testData)
    #expect(challenge.part2() == 6)
  }
}
