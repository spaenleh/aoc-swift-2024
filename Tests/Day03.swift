import Testing

@testable import aoc

@Suite("Day03")
struct Day03Tests {
  let testData = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day03(data: testData)
    #expect(challenge.part1() == 161)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day03(data: testData)
    #expect(challenge.part2() == 0)
  }
}