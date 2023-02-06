//
//  ProfileHeader.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

final class ProfileHeader: UICollectionReusableView {

    // MARK: - Properties
    var viewModel: ProfileViewModel? {
        didSet { configure() }
    }

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
        label.text = "0\nRating"
        return label
    }()

    private let bookmarkLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "0\nBookmark"
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

    private let ratingUnderLineView: UIView = {
        let line = UIView()
        line.backgroundColor = appColor
        return line
    }()

    private let bookmarkUnderLineView: UIView = {
        let line = UIView()
        line.backgroundColor = appColor
        line.isHidden = true
        return line
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
        ratingUnderLineView.isHidden = false
        bookmarkUnderLineView.isHidden = true

        viewModel?.isRatingListMode.value = true
    }

    @objc func tappedBookmarkButton() {
        ratingButton.setImage(UIImage(systemName: "star"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        ratingUnderLineView.isHidden = true
        bookmarkUnderLineView.isHidden = false

        viewModel?.isRatingListMode.value = false
    }

    // MARK: - Helpers
    func configure() {
        guard let viewModel else { return }
        ratingsLabel.text = viewModel.ratingsLabelText
        bookmarkLabel.text = viewModel.bookmarkLabelText

        print(viewModel.ratingData)
    }
}

// MARK: - Layout
extension ProfileHeader {
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

        addSubview(ratingUnderLineView)
        ratingUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(ratingButton.snp.bottom).inset(4)
            make.left.right.equalTo(ratingButton)
            make.height.equalTo(4)
        }

        addSubview(bookmarkUnderLineView)
        bookmarkUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(bookmarkButton.snp.bottom).inset(4)
            make.left.right.equalTo(bookmarkButton)
            make.height.equalTo(4)
        }
    }
}
