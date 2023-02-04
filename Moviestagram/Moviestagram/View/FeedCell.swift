//
//  FeedCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import Kingfisher

protocol FeedCellDelegate: AnyObject {
    func didExpandCell(_ cell: FeedCell)
}

final class FeedCell: UITableViewCell {

    // MARK: - Properties
    var isExpanded = false
    weak var delegate: FeedCellDelegate?

    // MARK: - UI Properties
    private lazy var movieProfileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = appColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMovieDetail))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()

    private lazy var movieTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("---", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(showMovieDetail), for: .touchUpInside)
        return button
    }()

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .white
        return iv
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "평균: ★"
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = ""
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private lazy var summaryExpandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("...더 보기", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.titleLabel?.font = .preferredFont(forTextStyle: .caption1)
        button.addTarget(self, action: #selector(expandSummary), for: .touchUpInside)
        return button
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

    override func prepareForReuse() {
        summaryLabel.numberOfLines = isExpanded ? 0 : 3
        summaryExpandButton.isHidden = isExpanded ? true : false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc private func showMovieDetail() {

    }

    @objc private func expandSummary() {
        isExpanded.toggle()
//        UIView.transition(with: summaryLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            self.summaryLabel.numberOfLines = self.isExpanded ? 0 : 3
//          })
//        summaryExpandButton.isHidden = isExpanded ? true : false
        summaryLabel.numberOfLines = isExpanded ? 0 : 3
        summaryExpandButton.isHidden = isExpanded ? true : false
//
        layoutIfNeeded()
        delegate?.didExpandCell(self)
    }

    // MARK: - Helpers
    func configure(with movie: Movie) {
        movieTitleButton.setTitle(movie.title, for: .normal)
        movieProfileImageView.setImage(with: movie.backgroundImage)
        posterImageView.setImage(with: movie.mediumCoverImage)
        summaryLabel.text = movie.summary
        ratingLabel.attributedText = ratingAttributedText(with: movie.rating ?? 0.0)
        yearLabel.text = "\(movie.year ?? 0)년"
        configureShowMoreButton()
    }

    private func ratingAttributedText(with rating: Double) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "평균: "))
        attributedString.append(NSAttributedString(string: "★", attributes: [.foregroundColor: appColor]))
        attributedString.append(NSAttributedString(string: "\(rating / 2)"))
        return attributedString
    }

    private func configureShowMoreButton() {
        addSubview(summaryExpandButton)
        summaryExpandButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        summaryExpandButton.anchor(bottom: summaryLabel.bottomAnchor,
                                     right: summaryLabel.rightAnchor)
    }

    private func configureLayout() {
        addSubview(movieProfileImageView)
        movieProfileImageView.anchor(top: topAnchor,
                                     left: leftAnchor,
                                     paddingTop: 12,
                                     paddingLeft: 12)
        movieProfileImageView.setDimensions(height: 40, width: 40)
        movieProfileImageView.layer.cornerRadius = 40 / 2

        addSubview(movieTitleButton)
        movieTitleButton.centerY(inView: movieProfileImageView,
                                 leftAnchor: movieProfileImageView.rightAnchor, paddingLeft: 8)

        addSubview(posterImageView)
        posterImageView.anchor(top: movieProfileImageView.bottomAnchor,
                               left: leftAnchor,
                               right: rightAnchor,
                               paddingTop: 8)
        posterImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true

        addSubview(ratingLabel)
        ratingLabel.anchor(top: posterImageView.bottomAnchor,
                           left: leftAnchor,
                           paddingTop: 8,
                           paddingLeft: 8)

        addSubview(summaryLabel)
        summaryLabel.anchor(top: ratingLabel.bottomAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: 8,
                            paddingLeft: 8,
                            paddingRight: 8)

        addSubview(yearLabel)
        yearLabel.anchor(top: summaryLabel.bottomAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         paddingTop: 8,
                         paddingLeft: 8,
                         paddingBottom: 8)
    }
}
