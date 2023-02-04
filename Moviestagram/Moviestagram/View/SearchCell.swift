//
//  SearchCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class SearchCell: UITableViewCell {
    // MARK: - Properties
    var movie: Movie? {
        didSet { configureData() }
    }

    // MARK: - UI Properties
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = appColor
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "평균: ★"
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2000년"
        label.font = .preferredFont(forTextStyle: .caption1)
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
        posterImageView.setImage(with: movie.mediumCoverImage)
        titleLabel.text = movie.title
        ratingLabel.attributedText = Util.ratingAttributedText(with: movie.rating ?? 0.0)
        yearLabel.text = "\(movie.year ?? 0)년"
    }

    private func configureLayout() {
        addSubview(posterImageView)
        let baseSize: CGFloat = 40
        posterImageView.setDimensions(height: baseSize * 3, width: baseSize * 2)
        posterImageView.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               paddingTop: 8,
                               paddingLeft: 8,
                               paddingBottom: 8,
                               paddingRight: 8)

        let stack = UIStackView(arrangedSubviews: [titleLabel, ratingLabel, yearLabel])
        stack.axis = .vertical
        stack.spacing = 8
        addSubview(stack)
        stack.centerY(inView: self,
                      leftAnchor: posterImageView.rightAnchor,
                      paddingLeft: 8)
        stack.anchor(right: rightAnchor, paddingRight: 8)
    }
}
