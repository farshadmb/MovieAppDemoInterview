//
//  Collection+Additionals.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

// MARK: - Equatable
extension Array where Element: Equatable {

    /// Remove first collection element that is equal to the given `object`
    ///
    /// - Parameter object: the object to remove from collection
    /// - Returns: if find object return true, otherwise return false
    @discardableResult
    mutating func remove(object: Element) -> Bool {
        if let index = firstIndex(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }

    /// Remove first collection element that predicate block return true
    ///
    /// - Parameter predicate: the predicate block
    /// - Returns: a `true` value if operation meet success, otherwise return false.
    @discardableResult
    mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.firstIndex(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }

    /// Append the object which does not exist in the collection.
    ///
    /// - Parameter object: the object that insert into a collection.
    /// - Returns: a `true` value if operation meet success, otherwise return false.
    @discardableResult
    mutating func append(unique object: Element) -> Bool {
        guard contains(object) == false else {
            return false
        }

        append(object)
        return true
    }

}

extension Array where Element: Hashable {

    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension Array {
    
    static func +=(lsh: inout [Element], rsh: [Element]?) {
        guard let rsh = rsh else {
           return
        }

        lsh += rsh
    }
}

extension Optional where Wrapped: Collection {

    /// Indicate the current optional Collection is empty or not.
    var isEmpty: Bool {
        switch self {
        case .some(let collection):
            return collection.isEmpty
        case .none:
            return true
        }
    }

}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise `nil`.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    func sorted<T: Comparable>(by key: KeyPath<Element,T>, incremental: Bool = true) -> [Element] {
        self.sorted { (element1, element2) -> Bool in
            if incremental {
                return element1[keyPath: key] < element2[keyPath: key]
            }else {
                return element1[keyPath: key] > element2[keyPath: key]
            }
        }
    }
}

/// Append right dictionary into left dictionary
///
/// - Parameters:
///   - left: the `Dictionary` object that append.
///   - right: the `Dictionary` object insert into left collection.
func += <K, V> (left: inout [K: V], right: [K: V]) {
    for (key, value) in right {
        left[key] = value
    }
}

///  Contact the two same dictionary into the new one.
/// - Parameters:
///   - left: the left operand `Dictionary` object.
///   - right: the right operand `Dictionray` object.
/// - Returns: the new contacted `Dictionary` object.
func + <K, V>(left: [K: V], right: [K: V]) -> [K: V] {
    var newValue = left
    newValue += right
    return newValue
}

extension Sequence {

    /// Group the `Sequence` by the given keypath
    /// - Parameter keyPath: <#keyPath description#>
    /// - Returns: the new grouped `Dictionary` object
    func group<T: Hashable>(by keyPath: KeyPath<Element,T>) -> [T: [Element]] {
        return Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
    }

    /// Group and map the `Sequence` by the given keypath
    /// - Parameter keyPath: <#keyPath description#>
    /// - Parameter map: <#map description#>
    /// - Returns: the new grouped `Dictionary` object
    func group<T: Hashable,G>(by keyPath: KeyPath<Element,T>, mapKeyTo map: @escaping (T) -> G) -> [G: [Element]] {
        return Dictionary(grouping: self, by: { map($0[keyPath: keyPath]) })
    }
}
