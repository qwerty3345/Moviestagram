//
//  ProfileRatingCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

protocol ProfileCell: UICollectionViewCell {
    func configure(with movie: Movie)
}

final class ProfileRatingCell: UICollectionViewCell, ProfileCell {

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
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    func configure(with movie: Movie) {
        postImageView.setImage(with: movie.mediumCoverImage)
    }
}
