//
//  FeedCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import SnapKit

final class FeedCell: UITableViewCell {
    // MARK: - Properties
    var movie: Movie? {
        didSet { configureData() }
    }

    // MARK: - UI Properties
    private lazy var movieProfileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()

    private lazy var movieTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.text = ".\n. \n. "
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2000년"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .lightGray
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    private func configureData() {
        guard let movie else { return }
        movieTitleButton.setTitle(movie.title, for: .normal)
        movieProfileImageView.setImage(with: movie.backgroundImage)
        posterImageView.setImage(with: movie.mediumCoverImage)
        summaryLabel.text = movie.summary
        ratingLabel.attributedText = Util.ratingAttributedText(with: movie.rating ?? 0.0)
        yearLabel.text = "\(movie.year ?? 0)년"
    }

    private func configureLayout() {
        addSubview(movieProfileImageView)
        movieProfileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(12)
            make.width.height.equalTo(40)
        }
        movieProfileImageView.layer.cornerRadius = 40 / 2

        addSubview(movieTitleButton)
        movieTitleButton.snp.makeConstraints { make in
            make.centerY.equalTo(movieProfileImageView)
            make.left.equalTo(movieProfileImageView.snp.right).offset(8)
        }

        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(movieProfileImageView.snp.bottom).offset(8)
            let baseSize: CGFloat = 100
            make.height.equalTo(baseSize * 3)
            make.width.equalTo(baseSize * 2)
        }

        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
        }

        addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }

        addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom).offset(8)
            make.left.bottom.equalToSuperview().inset(8)
        }
    }
}
