//
//  DetailController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class DetailController: UIViewController {
    // MARK: - Properties
    private let movie: Movie

    // MARK: - UI Properties
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = appColor
        return iv
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

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    // MARK: - Lifecycle
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureData()
        configureNavigationBarTitle(with: movie.title ?? "")
        view.backgroundColor = .white
    }

    // MARK: - Actions


    // MARK: - Helpers
    private func configureLayout() {
        view.addSubview(posterImageView)
        let baseSize: CGFloat = 120
        posterImageView.setDimensions(height: baseSize * 3, width: baseSize * 2)
        posterImageView.centerX(inView: view,
                                topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                paddingTop: 8)

        let stack = UIStackView(arrangedSubviews: [yearLabel, ratingLabel, summaryLabel])
        stack.axis = .vertical
        stack.spacing = 8
        view.addSubview(stack)
        stack.anchor(top: posterImageView.bottomAnchor,
                     left: view.leftAnchor,
                     bottom: view.bottomAnchor,
                     right: view.rightAnchor,
                     paddingTop: 8,
                     paddingLeft: 8,
                     paddingBottom: 8,
                     paddingRight: 8)
    }

    private func configureData() {
        posterImageView.setImage(with: movie.mediumCoverImage)
        summaryLabel.text = movie.summary
        ratingLabel.attributedText = Util.ratingAttributedText(with: movie.rating ?? 0.0)
        yearLabel.text = "\(movie.year ?? 0)년"
    }
}
