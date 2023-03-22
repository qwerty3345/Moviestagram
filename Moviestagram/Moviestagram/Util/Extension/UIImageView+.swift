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
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.3)),
                .forceTransition
            ]
        )
    }
}
