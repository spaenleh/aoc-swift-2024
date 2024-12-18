import Testing

@testable import aoc

@Suite("Day17")
struct Day17Tests {
  let testData = """
    Register A: 729
    Register B: 0
    Register C: 0

    Program: 0,1,5,4,3,0
    """

  @Test("parsing")
  func testParsing() async throws {
    let c = Day17(data: testData).initialize()
    let computer = Computer(instructions: c.instructions, registers: c.registers)

    #expect(computer.registers.A == 729)
    #expect(computer.registers.B == 0)
    #expect(computer.registers.C == 0)
    #expect(computer.instructions == [0, 1, 5, 4, 3, 0])

  }

  @Test("Common operations")
  func testOperations() async throws {
    var c1 = Computer(
      instructions: [2, 6], registers: Registers(A: 0, B: 0, C: 9)
    )
    #expect(c1.execute() == "")
    #expect(
      c1.registers.B == 1)

    var c2 = Computer(
      instructions: [5, 0, 5, 1, 5, 4], registers: Registers(A: 10, B: 0, C: 0)
    )
    #expect(c2.execute() == "0,1,2")

    var c3 = Computer(
      instructions: [0, 1, 5, 4, 3, 0], registers: Registers(A: 2024, B: 0, C: 0)
    )
    #expect(c3.execute() == "4,2,5,6,7,7,7,7,3,1,0")
    #expect(c3.registers.A == 0)

    var c4 = Computer(
      instructions: [1, 7], registers: Registers(A: 0, B: 29, C: 0)
    )
    #expect(c4.execute() == "")
    #expect(c4.registers.B == 26)

    var c5 = Computer(
      instructions: [4, 0], registers: Registers(A: 0, B: 2024, C: 43690)
    )
    #expect(c5.execute() == "")
    #expect(c5.registers.B == 44354)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day17(data: testData)
    #expect(challenge.part1() == "4,6,3,5,6,3,5,2,1,0")
  }

  @Test(.disabled("part2"))
  func testPart2() async throws {
    // 66245665785645
    let challenge = Day17(
      data: """
        Register A: 35048
        Register B: 0
        Register C: 0

        Program: 2,4,1,7,7,5,1,7,4,6,0,3,5,5,3,0
        """)
    let res = challenge.part1()
    let expectedRes = "2,4,1,7,7,5,1,7,4,6,0,3,5,5,3,0"
    #expect(res.count == expectedRes.count)
    #expect(res == expectedRes)
  }
}
