//
//  ProfileController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import Combine

final class ProfileController: UICollectionViewController {

    // MARK: - Properties

    private let environment: AppEnvironment
    private lazy var profileViewModel = ProfileViewModel(
        ratingMovieLocalRepository: environment.ratingMovieLocalRepository,
        bookmarkMovieLocalRepository: environment.bookmarkMovieLocalRepository
    )
    private var bag = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(environment: AppEnvironment) {
        self.environment = environment
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureRefreshControl()
        setNavigationBarTitle(with: Constants.Design.profileNavigationTitle)
        bind(to: profileViewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileViewModel.fetchLocalSavedData()
    }

    // MARK: - Actions

    @objc private func refreshProfile() {
        profileViewModel.fetchLocalSavedData()
    }

    // MARK: - Helpers

    private func configureCollectionView() {
        collectionView.registerCell(cellClass: ProfileRatingCell.self)
        collectionView.registerCell(cellClass: ProfileBookmarkCell.self)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }

    private func configureRefreshControl() {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshProfile), for: .valueChanged)
        collectionView.refreshControl = refresher
    }

    private func bind(to viewModel: ProfileViewModel) {
        viewModel.$bookmarkedMovies
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.collectionView.refreshControl?.endRefreshing()
                }
            }
            .store(in: &bag)

        viewModel.$ratedMovies
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.collectionView.refreshControl?.endRefreshing()
                }
            }
            .store(in: &bag)

        viewModel.$listMode
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &bag)
    }
}

// MARK: - UICollectionViewDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch profileViewModel.listMode {
        case .rating:
            return profileViewModel.numberOfRatedMovies
        case .bookmark:
            return profileViewModel.numberOfBookmarkedMovies
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProfileCell = {
            switch profileViewModel.listMode {
            case .rating:
                return collectionView.dequeueReusableCell(
                    cellClass: ProfileRatingCell.self, for: indexPath)
            case .bookmark:
                return collectionView.dequeueReusableCell(
                    cellClass: ProfileBookmarkCell.self, for: indexPath)
            }
        }()

        if let movie = profileViewModel.movieForCell(at: indexPath) {
            cell.configure(with: movie)
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              cellClass: ProfileHeader.self,
                                              for: indexPath)
        header.viewModel = profileViewModel
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = profileViewModel.movieForCell(at: indexPath) else { return }

        let detailVC = DetailController(environment: environment, movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
