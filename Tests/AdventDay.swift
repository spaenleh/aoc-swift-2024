import Testing

@testable import aoc

// One off test to validate that basic data load testing works
@Suite("AdventDay")
struct AdventDayTests {
  @Test func testInitData() async throws {
    let challenge = Day00()
    #expect(challenge.data.starts(with: "abcd"))
  }
}
