import Algorithms

struct Registers {
  var A = 0
  var B = 0
  var C = 0
}

struct Computer {
  var instructions = [Int]()
  var registers = Registers()
  var output = [Int]()

  func getComboOperand(_ operand: Int) -> Int {
    switch operand {
    case 0...3: operand
    case 4: registers.A
    case 5: registers.B
    case 6: registers.C
    case 7: 0  // invalid
    default: 0
    }
  }

  mutating func executeOp(_ ops: Int, _ operand: Int, combo comboOp: Int, pointer: Int) -> Int {
    func div(_ num: Int, _ denomShift: Int) -> Int {
      let denom = 1 << denomShift
      if denom > num || denomShift > num {
        return 0
      }
      return num / denom
    }

    switch ops {
    case 0:
      // adv
      registers.A = div(registers.A, comboOp)
    case 1:
      // bxl
      let res = registers.B ^ operand
      registers.B = res
    case 2:
      //bst
      let res = comboOp % 8
      registers.B = res
    case 3:
      // jnz
      if registers.A != 0 {
        // set the pointer to the value of the operand
        return operand
      }
    case 4:
      // bxc
      registers.B ^= registers.C
    case 5:
      // out
      output.append(comboOp % 8)
    case 6:
      // bdv
      registers.B = div(registers.A, comboOp)
    case 7:
      // cdv
      registers.C = div(registers.A, comboOp)
    default: break
    }
    return pointer + 2
  }

  mutating func execute() -> String {
    var pointer = 0

    while pointer < instructions.count {
      let op = instructions[pointer]
      let operand = instructions[pointer + 1]

      pointer = executeOp(op, operand, combo: getComboOperand(operand), pointer: pointer)
    }
    // join the output of program with commas
    return output.map { String($0) }.joined(separator: ",")
  }
}

struct Day17: AdventDay {
  var data: String

  func initialize() -> (instructions: [Int], registers: Registers) {
    let parts = data.trimmed().split(separator: "\n\n")
    let instructions = parts[1].trimmingPrefix("Program: ").integers(separator: ",")
    var registers = Registers()
    if let match = parts[0].firstMatch(
      of: /Register A: (\d+)\nRegister B: (\d+)\nRegister C: (\d+)/)
    {
      registers.A = Int(match.1) ?? 0
      registers.B = Int(match.2) ?? 0
      registers.C = Int(match.3) ?? 0
    }
    return (instructions: instructions, registers: registers)
  }

  func part1() -> String {
    let (instructions, registers) = initialize()
    var computer = Computer(instructions: instructions, registers: registers)
    return computer.execute()
  }

  func part2() -> Int {
    0
  }
}
