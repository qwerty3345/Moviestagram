//
//  SearchCell.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class SearchCell: UITableViewCell {
    // MARK: - Properties
    var viewModel: SearchCellViewModel? {
        didSet {
            configureData()
        }
    }

    // MARK: - UI Properties
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = Constants.Color.appColor
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Design.skeletonDashText
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Design.skeletonTextForRatingLabel
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Design.skeletonTextForYearLabel
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
        guard let viewModel else { return }
        posterImageView.setImage(with: viewModel.posterImageURLString)
        titleLabel.text = viewModel.titleLabelText
        ratingLabel.attributedText = viewModel.ratingLabelText
        yearLabel.text = viewModel.yearLabelText
    }
}

// MARK: - Layout
extension SearchCell {
    private func configureLayout() {
        addSubview(posterImageView)
        let baseSize: CGFloat = 40
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(baseSize * 3)
            make.width.equalTo(baseSize * 2)
            make.left.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }

        let stack = UIStackView(arrangedSubviews: [titleLabel, ratingLabel, yearLabel])
        stack.axis = .vertical
        stack.spacing = 8
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(posterImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        }
    }
}
