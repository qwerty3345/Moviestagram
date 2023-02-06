//
//  ReusableView.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}


