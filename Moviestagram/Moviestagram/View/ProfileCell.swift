//
//  ProfileCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

final class ProfileCell: UICollectionViewCell {

    // MARK: - UI Properties
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray

        addSubview(postImageView)
        postImageView.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configure(with movie: Movie) {
        postImageView.setImage(with: movie.mediumCoverImage)
    }

}
