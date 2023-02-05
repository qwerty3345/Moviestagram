//
//  ProfileHeader.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit
import SnapKit

protocol ProfileHeaderDelegate: AnyObject {
    func didChangeToRatingView()
    func didChangeToBookmarkView()
}

final class ProfileHeader: UICollectionReusableView {

    // MARK: - Properties
    weak var delegate: ProfileHeaderDelegate?

    // MARK: - UI Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = appColor
        iv.image = UIImage(systemName: "seal")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Mason Kim"
        return label
    }()

    private lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImageView, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private let ratingsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "0\n평가"
        return label
    }()

    private let bookmarkLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "0\n보고싶어요"
        return label
    }()

    private lazy var statusStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingsLabel, bookmarkLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var ratingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = appColor
        button.addTarget(self, action: #selector(tappedRatingButton), for: .touchUpInside)
        return button
    }()

    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = appColor
        button.addTarget(self, action: #selector(tappedBookmarkButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingButton, bookmarkButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc func tappedRatingButton() {
        ratingButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        delegate?.didChangeToRatingView()
    }

    @objc func tappedBookmarkButton() {
        ratingButton.setImage(UIImage(systemName: "star"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        delegate?.didChangeToBookmarkView()
    }

    // MARK: - Helpers
    func configure(ratings: Int, bookMarks: Int) {
        ratingsLabel.text = "\(ratings)\n평가"
        bookmarkLabel.text = "\(bookMarks)\n보고싶어요"
    }

    private func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        profileImageView.layer.cornerRadius = 80 / 2

        addSubview(profileStack)
        profileStack.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
                .inset(16)
        }


        addSubview(statusStack)
        statusStack.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(16)
            make.left.equalTo(profileStack.snp.right).offset(16)
            make.bottom.equalTo(profileStack)
        }

        addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(profileStack.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
