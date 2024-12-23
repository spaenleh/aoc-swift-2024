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
    #expect(isSafe("7 6 4 2 1".integers()) == true)
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

  @Test("perms")
  func testPerms() async throws {
    #expect(getPermutationsExcludingOneElement([1, 2, 3]) == [[2, 3], [1, 3], [1, 2]])
  }

  @Test("more cases")
  func testMoreCases() async throws {
    #expect(
      Day02(
        data: """
          1 2 3 4 10 11
          10 9 8 7 1
          """
      ).part2() == 1)
  }
}
