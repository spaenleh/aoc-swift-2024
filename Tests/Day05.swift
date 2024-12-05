import Testing

@testable import aoc

@Suite("Day05")
struct Day05Tests {
  let testData = """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """

  @Test("parsing")
  func testParsing() async throws {
    let challenge = Day05(data: testData)
    #expect(challenge.updates.count == 6)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day05(data: testData)
    #expect(challenge.part1() == 143)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day05(data: testData)
    #expect(challenge.part2() == 0)
  }
}
