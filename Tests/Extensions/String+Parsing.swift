import Testing

@testable import aoc

@Suite("String extensions")
struct StringExtensions {
  @Test("Trimming")
  func testTrimming() async throws {
    #expect("   hello    ".trimmed() == "hello")
    #expect("\n\nhello\n".trimmed() == "hello")
  }

  @Test("Concatenate Lines")
  func testConcatLines() async throws {
    #expect("h\ne\nl\nl\no".concatLines() == "hello")
  }

  @Test("Lines Parsing")
  func testLinesParsing() async throws {
    #expect("".lines() == [])
    #expect("\n\n".lines() == [])
    #expect("1\n2\n3\n".lines() == ["1", "2", "3"])
    #expect("1\n\n2".lines() == ["1", "2"])
  }

  @Test("Value parsing")
  func testValueParsing() async throws {
    #expect("".integers() == [])
    #expect("a".integers() == [])
    #expect("a 1 toto 1.3".integers() == [1])
    #expect("a 1 toto 1.3".doubles() == [1.0, 1.3])
    #expect("1 2 3 4".integers() == [1, 2, 3, 4])
  }

  @Test func testCharacterGrid() async throws {
    #expect(
      """
      abc
      def
      """.toCharacterGrid() == [["a", "b", "c"], ["d", "e", "f"]])
  }
}
