//
//  UIView+.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

extension UIView {
    static var hasNibFile: Bool {
        let nibName = String(describing: self)
        return Bundle.main.path(forResource: nibName, ofType: "nib") != nil
    }
}
