import Testing

@testable import aoc

@Suite("Display map")
struct MazeTests {
  @Test func testDisplay() async throws {
    let maze = Maze(
      from: """
        #######
        #S....#
        #..#..#
        #.###.#
        #.#...#
        #.##E.#
        #######
        """)
    print(maze.display())
  }
}
