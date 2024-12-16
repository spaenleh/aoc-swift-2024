import Algorithms
import SwiftGraph

struct Day16: AdventDay {
  var maze: Maze

  init(data: String) {
    maze = Maze(from: data)
  }

  func part1() -> Int {
    let allPaths = maze.findAllPathsToEnd()
    return allPaths.min() ?? 0
  }

  // func part1() -> Int {
  //   let nodes = maze.getNodes()
  //   let allEdges = nodes.map { [$0, Edge.inverted(edge: $0)] }.flatMap { $0 }
  //   let vertices = Array(Set(allEdges.map { [$0.from, $0.to] }.flatMap { $0 }))
  //   let graph: WeightedGraph<String, Int> = WeightedGraph<String, Int>(vertices: vertices)
  //   for edge in nodes {
  //     graph.addEdge(from: edge.from, to: edge.to, weight: edge.weight)
  //   }
  //   let (distances, pathDict) = graph.dijkstra(root: "S", startDistance: 0)
  //   let nameDistance: [String: Int?] = distanceArrayToVertexDict(
  //     distances: distances, graph: graph)
  //   // shortest distance from New York to San Francisco
  //   let temp = nameDistance["E"]
  //   print(temp)
  //   return (temp ?? 0) ?? 0
  // }

  func part2() -> Int {
    0
  }
}
