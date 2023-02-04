//
//  Font.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

enum CustomFont: String {
    case rachel = "Rachel"
}

extension UIFont {
    static func customFont(name: CustomFont, size: CGFloat) -> UIFont {
        return UIFont(name: name.rawValue, size: size) ?? UIFont()
    }
}
