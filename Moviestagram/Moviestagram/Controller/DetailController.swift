//
//  DetailController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import SnapKit

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
        setNavigationBarTitle(with: movie.title ?? "")
        view.backgroundColor = .white
    }

    // MARK: - API
    // TODO: 스크린샷 디테일 정보 받아와서, 화면에 띄워주기 (스크롤뷰로)

    // MARK: - Helpers
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

        let stack = UIStackView(arrangedSubviews: [yearLabel, ratingLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 24
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
        }

        contentView.addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(16)
            make.left.bottom.right.equalToSuperview().inset(16)
        }

        let divierView = UIView.lineView()
        contentView.addSubview(divierView)
        divierView.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(8)
            make.left.right.equalTo(summaryLabel)
        }
        
        // TODO: 스크린샷 스크롤뷰로 3개 띄우기
//        let screenshot1 = screenShotImageView(with: <#T##String#>)
    }

    private func configureData() {
        posterImageView.setImage(with: movie.mediumCoverImage)
        summaryLabel.text = movie.summary
        ratingLabel.attributedText = Util.ratingAttributedText(with: movie.rating ?? 0.0)
        yearLabel.text = "\(movie.year ?? 0)년 개봉"
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
