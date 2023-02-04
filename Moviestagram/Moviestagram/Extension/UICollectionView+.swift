//
//  UICollectionView+.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(cellClass: T.Type) {
        let identifier = String(describing: T.self)
        let nib = UINib(nibName: identifier, bundle: nil)

        if cellClass.hasNibFile {
            self.register(nib, forCellWithReuseIdentifier: identifier)
        } else {
            self.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable TableView cell")
        }
        return cell
    }
}
