import Testing

@testable import aoc

@Suite("Grid")
struct GridTests {
  @Test func testGridCreation() async throws {
    let unitGrid = Grid(raw: [["0"]])
    #expect(unitGrid.width == 1)
    #expect(unitGrid.height == 1)
    let highGrid = Grid(raw: [["1"], ["2"]])

    #expect(highGrid.width == 1)
    #expect(highGrid.height == 2)
  }
}
