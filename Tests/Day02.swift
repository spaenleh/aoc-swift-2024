import Testing

@testable import aoc

@Suite("Day02")
struct Day02Tests {
  let testData = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

  @Test("report analyzer")
  func name() async throws {
    #expect(Report("7 6 4 2 1").value == [7, 6, 4, 2, 1])
    #expect(ReportAnalyzer().isSafe(report: Report("7 6 4 2 1")) == true)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day02(data: testData)
    #expect(challenge.part1() == 2)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day02(data: testData)
    #expect(challenge.part2() == 4)
  }
}
