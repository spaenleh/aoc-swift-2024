import Testing

@testable import aoc

@Suite("Coord")
struct CoordTest {
  @Test("Initialize Coord")
  func testInit() async throws {
    let coord = Coord(rawValue: "0,0")
    #expect(coord?.x == 0)
    #expect(coord?.y == 0)
  }

  @Test("Description")
  func testDescription() async throws {
    let coord = Coord(x: 2, y: 3)
    #expect("\(coord)" == "2,3")
  }

  @Test func testDivision() async throws {
    #expect(Coord(x: 2, y: 4) / 2 == Coord(x: 1, y: 2))
  }
}
