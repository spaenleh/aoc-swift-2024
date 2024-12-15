import Algorithms
import Foundation

func getDocumentsDirectory() -> URL {
  let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
  return paths[0]
}

struct Robot: CustomStringConvertible {
  var description: String {
    "p=\(pos) v=\(velocity)"
  }

  var pos: Coord
  var velocity: Coord

  func after(n: Int = 100, width: Int = 101, height: Int = 103) -> Self {
    var newPos = self.pos + (self.velocity * n)
    newPos.x %= width
    newPos.y %= height
    if newPos.x < 0 {
      newPos.x += width
    }
    if newPos.y < 0 {
      newPos.y += height
    }
    return Self(pos: newPos, velocity: self.velocity)
  }
}
extension Robot {
  init(_ values: [Coord]) {
    pos = values[0]
    velocity = values[1]
  }
}

struct Picture {
  var width: Int
  var height: Int

  func toGrid(robots: [Robot]) -> Grid<Bool> {
    var grid = Grid<Bool>(
      raw: [[Bool]](repeating: [Bool](repeating: false, count: width), count: height))
    let robotPos = robots.reduce(into: [Coord: Bool]()) { partialResult, r in
      partialResult[r.pos] = true
    }
    for (pos, _) in robotPos {
      grid.raw[pos.y][pos.x] = true
    }
    return grid
  }

  func save(for robots: [Robot], at: Int) {

    let imageData = toGrid(robots: robots).toImage()
    let filename = getDocumentsDirectory().appendingPathComponent("aoc/\(at).pbm")

    do {
      try imageData.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
    } catch {
      print("could not write")
      // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    }
  }
}

struct Day14: AdventDay {
  var robots: [Robot] = [Robot]()
  init(data: String) {
    robots = data.lines().map { l in
      Robot(
        l.replacing(/(p=)|(v=)/, with: "").split(separator: " ").map {
          Coord.init(rawValue: String($0))!
        })
    }
  }

  func part1() -> Int {
    let width = 101
    let height = 103
    // let width = 11
    // let height = 7
    let middleX = width / 2
    let middleY = height / 2
    let nRobots = robots.map { r in
      r.after(n: 100, width: width, height: height)
    }
    let quad1 = nRobots.filter {
      $0.pos.x >= 0 && $0.pos.x < middleX && $0.pos.y >= 0 && $0.pos.y < middleY
    }
    let quad2 = nRobots.filter {
      $0.pos.x > middleX && $0.pos.y >= 0 && $0.pos.y < middleY
    }
    let quad3 = nRobots.filter {
      $0.pos.x >= 0 && $0.pos.x < middleX && $0.pos.y > middleY
    }
    let quad4 = nRobots.filter {
      $0.pos.x > middleX && $0.pos.y > middleY
    }
    let quads = [quad1.count, quad2.count, quad3.count, quad4.count]
    return quads.reduce(1, *)
  }

  func part2_naive() -> Int {
    let picture = Picture(width: 101, height: 103)
    let nFrames = 8000
    for iter in 7000..<nFrames {
      let nRobots = robots.map { r in
        r.after(n: iter, width: picture.width, height: picture.height)
      }
      picture.save(for: nRobots, at: iter)
      if iter % 1000 == 0 {
        print(iter)
      }
    }
    return 0
  }

  func part2() -> Int {
    let width = 101
    let height = 103
    let picture = Picture(width: width, height: height)
    for iter in 0..<(width * height) {
      let nRobots = robots.map { r in
        r.after(n: iter, width: width, height: height)
      }
      picture.save(for: nRobots, at: iter)
    }
    return 0
  }
}
