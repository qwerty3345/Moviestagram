//
//  FeedController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class FeedController: UITableViewController {

    // MARK: - Properties
    private let viewModel = FeedViewModel()

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
        setNavigationBarTitle(with: "Movies")
        tableView.tableFooterView = spinnerFooter

        viewModel.fetchMovie()
        bind(to: viewModel)
    }

    // MARK: - Actions
    @objc func refreshFeed() {
        viewModel.fetchMovie()
    }

    // MARK: - Helpers
    private func bind(to viewModel: FeedViewModel) {
        viewModel.movies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func configureTableView() {
        tableView.registerCell(cellClass: FeedCell.self)
        tableView.separatorStyle = .none
        setTableViewRowHeight()
    }

    private func setTableViewRowHeight() {
        var rowHeight = view.frame.width + 8 + 40 + 8
        rowHeight += 50
        rowHeight += 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = rowHeight
    }

    private func configureNavigationMenu() {
        let menuItems: [UIAction] = [
            UIAction(title: "인기순 정렬",
                     image: UIImage(systemName: "heart"),
                     handler: { _ in self.viewModel.searchOption = .sortByLike }),
            UIAction(title: "평점순 정렬",
                     image: UIImage(systemName: "star"),
                     handler: { _ in self.viewModel.searchOption = .sortByRating })]

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
        return viewModel.numberOfMovies == 0 ? 2 : viewModel.numberOfMovies
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: FeedCell.self, for: indexPath)

        if let movie = viewModel.movieForCell(at: indexPath) {
            cell.movie = movie
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedController {
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel.movieForCell(at: indexPath) else { return }
        let detailVC = DetailController(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfMovies - 1 {
            print("load more!")
            viewModel.loadMoreMovieData()
        }
    }
}
