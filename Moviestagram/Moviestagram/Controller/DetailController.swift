//
//  DetailController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class DetailController: UIViewController {

    // MARK: - Properties
    private let detailViewModel: DetailViewModel

    // MARK: - UI Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()

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
        label.textAlignment = .center
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

    private let ratingStarImageViews: [UIImageView] = {
        var imageViews: [UIImageView] = []
        for _ in 0..<5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star"))
            starImageView.tintColor = appColor
            starImageView.snp.makeConstraints { make in
                make.height.width.equalTo(40)
            }
            imageViews.append(starImageView)
        }
        return imageViews
    }()

    private lazy var ratingStarStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: ratingStarImageViews)
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var ratingSlider: RatingSlider = {
        let slider = RatingSlider()
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.thumbTintColor = .clear
        slider.minimumValue = 0
        slider.maximumValue = 10
        return slider
    }()

    private lazy var bookmarkButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(tappedBookmarkButton))
        button.tintColor = appColor
        return button
    }()


    // MARK: - Lifecycle
    init(movie: Movie) {
        detailViewModel = DetailViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureData()
        configureNavigationBar()
        view.backgroundColor = .white

        bind(to: detailViewModel)
    }


    @objc private func tappedBookmarkButton() {
        detailViewModel.tappedBookmark()
    }

    // MARK: - Helpers
    private func bind(to viewModel: DetailViewModel) {
        viewModel.movie.bind { [weak self] movie in
            self?.setStarImages(withRating: movie.myRating ?? 0)
        }
        viewModel.isBookmarked.bind { [weak self] isBookmarked in
            let bookmarkImageName = isBookmarked ? "bookmark" : "bookmark.fill"
            self?.bookmarkButton.image = UIImage(systemName: bookmarkImageName)
        }
    }

    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = bookmarkButton
        setNavigationBarTitle(with: detailViewModel.movie.value.title ?? "")
    }

    private func configureData() {
        posterImageView.setImage(with: detailViewModel.posterImageURLString)
        summaryLabel.text = detailViewModel.summaryLabelText
        ratingLabel.attributedText = detailViewModel.ratingLabelAttributedString
        yearLabel.text = detailViewModel.yearLabelText
    }

    private func screenShotImageView(with imageURL: String) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = appColor
        iv.setImage(with: imageURL)
        return iv
    }
}

// MARK: - Layout
extension DetailController {
    private func configureLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            let baseSize: CGFloat = 120
            make.width.equalTo(baseSize * 2)
            make.height.equalTo(baseSize * 3)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }

        let infoStack = UIStackView(arrangedSubviews: [yearLabel, ratingLabel])
        infoStack.axis = .horizontal
        infoStack.distribution = .fillEqually
        infoStack.spacing = 24
        contentView.addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
        }

        contentView.addSubview(ratingStarStack)
        ratingStarStack.snp.makeConstraints { make in
            make.top.equalTo(infoStack.snp.bottom)
            make.left.right.equalTo(posterImageView)
        }

        contentView.addSubview(ratingSlider)
        ratingSlider.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(ratingStarStack)
        }


        contentView.addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingStarStack.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().inset(16)
        }

        let divierView = UIView()
        divierView.backgroundColor = .lightGray
        contentView.addSubview(divierView)
        divierView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.top.equalTo(ratingStarStack.snp.bottom).offset(8)
            make.left.right.equalTo(summaryLabel)
        }


        // TODO: 스크린샷 스크롤뷰로 3개 띄우기
        //        let screenshot1 = screenShotImageView(with: <#T##String#>)
    }
}


// MARK: - Rating Slider
extension DetailController {
    @objc private func sliderValueChanged(_ sender: UISlider) {
        setStarImages(sliderValue: sender.value)
        detailViewModel.rating = floor(sender.value) / 2
    }

    private func setStarImages(withRating rating: Float) {
        setStarImages(sliderValue: rating * 2)
    }

    private func setStarImages(sliderValue: Float) {
        let value = Int(sliderValue)
        for (index, starImage) in ratingStarImageViews.enumerated() {
            if index < value / 2 {
                starImage.image = UIImage(systemName: "star.fill")
                continue
            }
            if value % 2 != 0 && index == value / 2 {
                starImage.image = UIImage(systemName: "star.leadinghalf.filled")
                continue
            }
            starImage.image = UIImage(systemName: "star")
        }
    }
}
