//
//  FeedController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import Combine

final class FeedController: UITableViewController {

    // MARK: - Properties
    private let feedViewModel = FeedViewModel(
        movieRemoteRepository: appEnvironment.movieRemoteRepository
    )
    private var bag = Set<AnyCancellable>()

    private lazy var spinnerFooter: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))

        let spinner = UIActivityIndicatorView()
        footerView.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        spinner.startAnimating()

        return footerView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureRefreshControl()
        configureNavigationMenu()
        setNavigationBarTitle(with: Constants.Design.feedNavigationTitle)

        feedViewModel.fetchMovie()
        bind(to: feedViewModel)
    }

    // MARK: - Actions
    @objc func refreshFeed() {
        feedViewModel.fetchMovie()
    }

    // MARK: - Helpers
    private func bind(to viewModel: FeedViewModel) {
        viewModel.$movies
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData(with: .curveEaseInOut)
                    self?.endRefreshing()
                }
            }
            .store(in: &bag)
    }

    private func configureTableView() {
        tableView.registerCell(cellClass: FeedCell.self)
        tableView.separatorStyle = .none
        setTableViewRowHeight()

        tableView.tableFooterView = spinnerFooter
    }

    private func setTableViewRowHeight() {
        var rowHeight = view.frame.width + 8 + 40 + 8
        rowHeight += 50
        rowHeight += 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = rowHeight
    }

    private func configureNavigationMenu() {
        let sortByLikeAction = UIAction(
            title: Constants.Design.sortByLikeActionTitle,
            image: UIImage(systemName: "heart"),
            handler: { _ in
                self.feedViewModel.searchOption = .sortByLike
            })

        let sortByRatingAction = UIAction(
            title: Constants.Design.sortByLikeRatingActionTitle,
            image: UIImage(systemName: "star"),
            handler: { _ in
                self.feedViewModel.searchOption = .sortByRating
            })

        let menuItems: [UIAction] = [sortByLikeAction, sortByRatingAction]

        let menu = UIMenu(image: UIImage(systemName: "ellipsis.circle"), children: menuItems)
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)

        navigationItem.rightBarButtonItem = menuBarButton
    }

    private func configureRefreshControl() {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        tableView.refreshControl = refresher
    }

    private func endRefreshing() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    private func scrollToTop(animate: Bool) {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animate)
        }
    }
}

// MARK: - UITableViewDataSource
extension FeedController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        guard feedViewModel.numberOfMovies != 0 else {
            return 2
        }
        return feedViewModel.numberOfMovies
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: FeedCell.self, for: indexPath)

        if let movie = feedViewModel.movieForCell(at: indexPath) {
            cell.viewModel = FeedCellViewModel(movie: movie)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedController {
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        guard let movie = feedViewModel.movieForCell(at: indexPath) else { return }
        let detailVC = DetailController(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if indexPath.row == feedViewModel.numberOfMovies - 1 {
            feedViewModel.loadMoreMovieData()
        }
    }
}
