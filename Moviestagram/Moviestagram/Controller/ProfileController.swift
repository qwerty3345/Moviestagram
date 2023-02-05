//
//  ProfileController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class ProfileController: UICollectionViewController {

    // MARK: - Properties
    private var bookmarkedMovies: [Movie] = [] {
        didSet { collectionView.reloadData() }
    }
    private var ratedMovies: [Movie] = [] {
        didSet { collectionView.reloadData() }
    }

    private var isRatingListMode = true

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setNavigationBarTitle(with: "Mason Kim")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ratedMovies = MovieLocalRepository.shared.ratedMovies
    }

    // MARK: - Actions


    // MARK: - Helpers
    private func configureCollectionView() {
        collectionView.registerCell(cellClass: ProfileRatingCell.self)
        collectionView.registerCell(cellClass: ProfileBookmarkCell.self)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isRatingListMode ? ratedMovies.count : bookmarkedMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isRatingListMode {
            let cell = collectionView.dequeueReusableCell(cellClass: ProfileRatingCell.self, for: indexPath)
            if let movie = ratedMovies[safe: indexPath.row] {
                cell.configure(with: movie)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(cellClass: ProfileBookmarkCell.self, for: indexPath)
            if let movie = bookmarkedMovies[safe: indexPath.row] {
                cell.configure(with: movie)
            }
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, cellClass: ProfileHeader.self , for: indexPath)
        header.configure(ratings: ratedMovies.count, bookMarks: bookmarkedMovies.count)
        header.delegate = self
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = isRatingListMode
                ? ratedMovies[safe: indexPath.row]
                : bookmarkedMovies[safe: indexPath.row] else { return }

        let detailVC = DetailController(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

// MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func didChangeToRatingView() {
        isRatingListMode = true
        collectionView.reloadData()
    }

    func didChangeToBookmarkView() {
        isRatingListMode = false
        collectionView.reloadData()
    }
}
