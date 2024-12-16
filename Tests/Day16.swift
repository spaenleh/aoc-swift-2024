import Testing

@testable import aoc

@Suite("Day16")
struct Day16Tests {
  let testData = """
    ###############
    #.......#....E#
    #.#.###.#.###.#
    #.....#.#...#.#
    #.###.#####.#.#
    #.#.#.......#.#
    #.#.#####.###.#
    #...........#.#
    ###.#.#####.#.#
    #...#.....#.#.#
    #.#.#.###.#.#.#
    #.....#...#.#.#
    #.###.#.#.#.#.#
    #S..#.....#...#
    ###############
    """

  @Test(.disabled("part1"))
  func testPart1() async throws {
    let challenge = Day16(data: testData)
    #expect(challenge.part1() == 7036)
  }

  @Test("Nodes creation")
  func testNodes() async throws {
    let testNodeData = """
      #####
      #..E#
      #.###
      #.###
      #S###
      #####
      """
    let maze = Maze(from: testNodeData)
    let nodes = maze.getNodes()
    print(nodes)
    #expect(nodes.count == 4)
    // #expect(nodes == )
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day16(data: testData)
    #expect(challenge.part2() == 0)
  }
}
