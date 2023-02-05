//
//  UITableView+.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

extension UITableViewCell: ReusableView { }

extension UITableView {
    func registerCell<T: UITableViewCell>(cellClass: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)

        if cellClass.hasNibFile {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable TableView cell")
        }
        return cell
    }

    func reloadData(with animation: AnimationOptions) {
        UIView.transition(with: self,
                          duration: 0.4,
                          options: animation,
                          animations: { self.reloadData() })
    }
}
