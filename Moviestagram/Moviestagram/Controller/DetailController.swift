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
    private let scrollView = UIScrollView()
    private let contentView = UIView()

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
        label.text = "★"
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2000년"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
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

    // MARK: - API
    // TODO: 스크린샷 디테일 정보 받아와서, 화면에 띄워주기 (스크롤뷰로)

    // MARK: - Helpers
    private func configureLayout() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(contentView)
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        contentView.addSubview(posterImageView)
        let baseSize: CGFloat = 120
        posterImageView.setDimensions(height: baseSize * 3, width: baseSize * 2)
        posterImageView.centerX(inView: contentView,
                                topAnchor: contentView.topAnchor,
                                paddingTop: 8)

        let stack = UIStackView(arrangedSubviews: [yearLabel, ratingLabel])
        stack.axis = .vertical
        stack.spacing = 8
        contentView.addSubview(stack)
        stack.centerX(inView: contentView,
                      topAnchor: posterImageView.bottomAnchor,
                      paddingTop: 8)

        contentView.addSubview(summaryLabel)
        summaryLabel.anchor(top: stack.bottomAnchor,
                            left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 16,
                            paddingLeft: 16,
                            paddingRight: 16)

        let divierView = UIView.lineView()
        contentView.addSubview(divierView)
        divierView.anchor(top: stack.bottomAnchor,
                          left: summaryLabel.leftAnchor,
                          right: summaryLabel.rightAnchor,
                          paddingTop: 8)

        let recommendImageView1 = generateRecommendImageView(with: <#T##String#>)
    }

    private func configureData() {
        posterImageView.setImage(with: movie.mediumCoverImage)
        summaryLabel.text = movie.summary
        ratingLabel.attributedText = Util.ratingAttributedText(with: movie.rating ?? 0.0)
        yearLabel.text = "\(movie.year ?? 0)년 개봉"
    }

    private func generateRecommendImageView(with imageURL: String) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = appColor
        iv.setImage(with: imageURL)
        return iv
    }

}
