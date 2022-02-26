//
//  Collections+Ext.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import Foundation

extension Collection {

    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func get(at index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
