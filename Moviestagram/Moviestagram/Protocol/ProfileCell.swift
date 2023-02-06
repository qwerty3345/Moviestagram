//
//  ProfileCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import UIKit

protocol ProfileCell: UICollectionViewCell {
    func configure(with movie: Movie)
}
