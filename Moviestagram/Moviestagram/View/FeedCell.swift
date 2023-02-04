//
//  FeedCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import Kingfisher

final class FeedCell: UITableViewCell {

    // MARK: - UI Properties
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(showUserProfile))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()

    private lazy var movieTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("name", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(showUserProfile), for: .touchUpInside)
        return button
    }()

    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        return iv
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()

    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        return button
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "1 like"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 테스트..."
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0시간 전"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,
                                left: leftAnchor,
                                paddingTop: 12,
                                paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2

        addSubview(movieTitleButton)
        movieTitleButton.centerY(inView: profileImageView,
                               leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)

        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true

        congifureActionButtons()

        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor,
                          left: leftAnchor,
                          paddingTop: -4,
                          paddingLeft: 8)

        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor,
                            left: leftAnchor,
                            paddingTop: 8,
                            paddingLeft: 8)

        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor,
                             left: leftAnchor,
                             paddingTop: 8,
                             paddingLeft: 8)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc private func showUserProfile() {
    }

    @objc private func didTapComments() {
    }

    @objc private func didTapLike() {
    }

    @objc private func didTapShare() {
    }

    // MARK: - Helpers

    func configure(with movie: Movie) {
        movieTitleButton.setTitle(movie.title, for: .normal)
        profileImageView.setImage(with: movie.backgroundImage)
        postImageView.setImage(with: movie.mediumCoverImage)
    }

    private func congifureActionButtons() {
        let stack = UIStackView(arrangedSubviews: [likeButton, commentButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        addSubview(stack)
        stack.anchor(top: postImageView.bottomAnchor,
                     height: 50)
    }
}
