/// An iterator-sequence for the Cartesian product of multiple sequences of the same type.
/// See `product(_:)`.
public struct CartesianProduct<S: Sequence>: IteratorProtocol, Sequence {

  private let sequences: [S]
  private var iterators: [S.Iterator]
  private var currentValues: [S.Iterator.Element] = []

  fileprivate init(_ sequences: [S]) {
    self.sequences = sequences
    self.iterators = sequences.map { $0.makeIterator() }
  }

  public mutating func next() -> [S.Iterator.Element]? {
    guard !currentValues.isEmpty else {
      var firstValues: [S.Iterator.Element] = []
      for index in iterators.indices {
        guard let value = iterators[index].next() else {
          return nil
        }
        firstValues.append(value)
      }
      currentValues = firstValues
      return firstValues
    }

    for index in currentValues.indices.reversed() {
      if let value = iterators[index].next() {
        currentValues[index] = value
        return currentValues
      }

      guard index != 0 else {
        return nil
      }

      iterators[index] = sequences[index].makeIterator()
      currentValues[index] = iterators[index].next()!
    }

    return currentValues
  }
}

/// Returns an iterator-sequence for the Cartesian product of the sequence repeated with itself a number of times.
/// ```
/// let values = product([1, 2, 3], repeated: 2)
/// // Equivalent to product([1, 2, 3], [1, 2, 3])
/// ```
/// - Parameters:
///    - sequence: The sequence from which to compute the product.
///    - repeated: The number of times to repeat the sequence with itself in computing the product.
/// - Returns: An iterator-sequence for the Cartesian product of the sequence repeated with itself a number of times.
public func product<S: Sequence>(_ sequence: S, repeated: Int) -> CartesianProduct<S> {
  let sequences = Array(repeating: sequence, count: repeated)
  return CartesianProduct(sequences)
}
