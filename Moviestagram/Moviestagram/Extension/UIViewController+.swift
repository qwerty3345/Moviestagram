//
//  UIViewController+.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

extension UIViewController {
    func configureNavigationBarTitle(with title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.customFont(name: .rachel, size: 24)
        ]
    }
}
