//
//  UIImageView+.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with imageUrl: String?) {
        guard let url = URL(string: imageUrl ?? "") else { return }
        kf.setImage(with: url)
    }
}
