//
//  UITableView+.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(cellClass: T.Type) {
        let identifier = String(describing: T.self)
        let nib = UINib(nibName: identifier, bundle: nil)

        if cellClass.hasNibFile {
            self.register(nib, forCellReuseIdentifier: identifier)
        } else {
            self.register(cellClass, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable TableView cell")
        }
        return cell
    }
}
