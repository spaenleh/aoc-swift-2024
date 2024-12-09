import Algorithms

struct Space: CustomStringConvertible {
  var fileId: Int?
  var capacity: Int

  var description: String {
    "\(fileId ?? -1)(\(capacity))"
  }
}

struct IndexedSpace: CustomStringConvertible {
  var fileId: Int?
  var capacity: Int
  var startIndex: Int

  var description: String {
    "\(fileId ?? -1)(\(capacity))"
  }
}
extension IndexedSpace {
  init(space: Space, startIndex: Int) {
    capacity = space.capacity
    fileId = space.fileId
    self.startIndex = startIndex
  }
}

struct File: CustomStringConvertible {
  var startIndex: Int
  var fileId: Int
  var capacity: Int

  var description: String {
    "\(fileId)=(\(capacity)) \(startIndex)"
  }

  func computeValue() -> Int {
    (startIndex..<startIndex + capacity).map { $0 * fileId }.sum
  }
}
extension File {
  init(space: Space, startIndex: Int) {
    capacity = space.capacity
    fileId = space.fileId ?? 0
    self.startIndex = startIndex
  }
  init(space: IndexedSpace) {
    capacity = space.capacity
    fileId = space.fileId ?? 0
    startIndex = space.startIndex
  }
}

typealias SpaceIndex = [Int: Space]

struct Day09: AdventDay {
  var data: String

  func parse(data: String) -> (disk: SpaceIndex, free: SpaceIndex) {
    var pointer = 0
    var disk: [Int: Space] = [Int: Space]()
    var free: [Int: Space] = [Int: Space]()
    for (idx, block) in data.trimmed().enumerated() {
      let capacity = Int(String(block)) ?? 0
      let isFree = idx % 2 != 0
      let fileId: Int? = if isFree { nil } else { idx / 2 }
      let space = Space(fileId: fileId, capacity: capacity)

      // store free space
      if isFree {
        free[pointer] = space
      } else {
        disk[pointer] = space
      }

      pointer += capacity
    }

    return (disk, free: free.filter { $0.value.capacity != 0 })
  }

  func part1() -> Int {
    var (disk, free) = parse(data: data)
    var newDisk = [File]()
    var pointer = 0
    var iterNum = 0
    while disk.count > 0 {
      iterNum += 1
      if let file = disk[pointer] {
        // add the file to the new disk allocation
        newDisk.append(File(startIndex: pointer, fileId: file.fileId ?? 0, capacity: file.capacity))
        // remove from disk copy
        disk.removeValue(forKey: pointer)
        // increment the pointer
        pointer += file.capacity
        if disk.count == 0 {
          print("we are done here !")
          break
        }
        continue
      }
      if let freeSpace = free[pointer] {
        // find the file to fill the gap
        let lastFileIndex = disk.keys.max() ?? 0
        guard let file = disk[lastFileIndex] else {
          print("no file available")
          continue
        }

        if freeSpace.capacity >= file.capacity {
          // add file to the list
          newDisk.append(
            File(startIndex: pointer, fileId: file.fileId ?? 0, capacity: file.capacity))
          // remove the file from the disk
          disk.removeValue(forKey: lastFileIndex)
          // remove the free space and insert the new free space
          free.removeValue(forKey: pointer)

          let newPointer = pointer + file.capacity
          if freeSpace.capacity != file.capacity {
            // add a new free space
            let newCapacity = freeSpace.capacity - file.capacity
            free[newPointer] = Space(capacity: newCapacity)
          }
          pointer = newPointer
          continue
        }
        if freeSpace.capacity < file.capacity {
          let newFile = File(
            startIndex: pointer, fileId: file.fileId ?? 0, capacity: freeSpace.capacity)
          // add file to the list
          newDisk.append(newFile)
          // reduce the file on the disk
          disk[lastFileIndex]?.capacity -= freeSpace.capacity
          // remove the free space and insert the new free space
          free.removeValue(forKey: pointer)

          let newPointer = pointer + freeSpace.capacity
          pointer = newPointer
          continue
        }
      }
    }

    return newDisk.map { file in
      file.computeValue()
    }.sum
  }

  func parse2(data: String) -> (disk: [IndexedSpace], free: [IndexedSpace]) {
    var pointer = 0
    var disk: [IndexedSpace] = [IndexedSpace]()
    var free: [IndexedSpace] = [IndexedSpace]()
    for (idx, block) in data.trimmed().enumerated() {
      let capacity = Int(String(block)) ?? 0
      let isFree = idx % 2 != 0
      let fileId: Int? = if isFree { nil } else { idx / 2 }
      let space = IndexedSpace(fileId: fileId, capacity: capacity, startIndex: pointer)
      // store free space
      if isFree {
        free.append(space)
      } else {
        disk.append(space)
      }
      pointer += capacity
    }
    return (disk, free)
  }

  func part2() -> Int {
    var (disk, free) = parse2(data: data)
    // first file will always be at the beginning
    var newDisk: [File] = [File(space: disk[0])]
    for file in disk[1..<disk.count].reversed() {
      // find the first spot that is available
      if let spotIndex = free.firstIndex(where: {
        $0.capacity >= file.capacity && $0.startIndex < file.startIndex
      }) {
        let spot = free[spotIndex]
        var newFile = File(space: file)
        newFile.startIndex = spot.startIndex
        newDisk.append(newFile)
        if spot.capacity == file.capacity {
          free.remove(at: spotIndex)
        } else {
          free[spotIndex].capacity -= file.capacity
          free[spotIndex].startIndex += file.capacity
        }
      } else {
        newDisk.append(File(space: file))
      }
    }

    return newDisk.map { file in
      file.computeValue()
    }.sum
  }
}
