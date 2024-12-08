import Testing

@testable import aoc

@Suite("Day08")
struct Day08Tests {
  let testData = """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day08(data: testData)
    #expect(challenge.part1() == 14)
  }

  @Test("simple part 2")
  func testSimplePart2() async throws {
    let challenge = Day08(
      data: """
        T.........
        ...T......
        .T........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        """)
    #expect(challenge.part2() == 9)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day08(data: testData)
    #expect(challenge.part2() == 34)
  }
}
