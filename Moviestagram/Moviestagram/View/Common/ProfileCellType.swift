//
//  ProfileCellType.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import UIKit

protocol ProfileCellType: UICollectionViewCell {
    func configure(with movie: Movie)
}
