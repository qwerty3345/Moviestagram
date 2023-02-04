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
    init(movie: Movie) {
        self.movie = movie
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    // MARK: - Actions


    // MARK: - Helpers
    private func configureLayout() {
        view.addSubview(posterImageView)
        let baseSize: CGFloat = 40
        posterImageView.setDimensions(height: baseSize * 3, width: baseSize * 2)
        posterImageView.anchor(top: view.topAnchor,
                               left: view.leftAnchor,
                               paddingTop: 8,
                               paddingLeft: 8)
    }
}
