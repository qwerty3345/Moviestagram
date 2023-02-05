//
//  UICollectionView+.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

extension UICollectionReusableView: ReusableView { }

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(cellClass: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)

        if cellClass.hasNibFile {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable CollectionView cell")
        }
        return cell
    }

    func register<T: UICollectionReusableView>(_ viewClass: T.Type, forSupplementaryViewOfKind elementKind: String) {
        register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let identifier = String(describing: T.self)
        let nib = UINib(nibName: identifier, bundle: nil)

        if cellClass.hasNibFile {
            self.register(nib, forCellWithReuseIdentifier: identifier)
        } else {
            self.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable SupplementaryView")
        }
        return supplementaryView
    }
}
