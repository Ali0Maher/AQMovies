//
//  UICollectionView+Ext.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import UIKit

public extension UICollectionView {
    // MARK: - Registration - Cell
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    // MARK: - Dequeuing - Cell
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type \(T.self)")
        }

        return cell
    }
}
