//
//  FeedController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class FeedController: UITableViewController {

    // MARK: - Properties
    private var currentPage: Int {
        movies.count / 20
    }
    private var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var searchOption: FetchMovieOptionQuery = .sortByLike {
        didSet { fetchMovie(by: searchOption) }
    }

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
        fetchMovie(by: .sortByLike)
        tableView.tableFooterView = spinnerFooter
    }

    // MARK: - API
    private func fetchMovie(by option: FetchMovieOptionQuery) {
        MovieRemoteRepository.shared.fetchMovie(with: option) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }

            self.endRefreshing()
        }
    }

    private func loadMoreMovieData(by option: FetchMovieOptionQuery) {
        print("movies - \(movies.count)")
        print("movies - \(movies.count / 20 + 1)")
        print("load more - \(currentPage + 1)")
        MovieRemoteRepository.shared.fetchMovie(with: [option, .page(currentPage + 1)]) { result in
            switch result {
            case .success(let movies):
                self.movies += movies
            case .failure(let error):
                print(error.localizedDescription)
            }

            self.endRefreshing()
        }
    }

    // MARK: - Actions
    @objc func refreshFeed() {
        fetchMovie(by: searchOption)
    }

    // MARK: - Helpers
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
                     handler: { _ in self.searchOption = .sortByLike }),
            UIAction(title: "평점순 정렬",
                     image: UIImage(systemName: "star"),
                     handler: { _ in self.searchOption = .sortByRating })]

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
}

// MARK: - UITableViewDataSource
extension FeedController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.isEmpty ? 2 : movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: FeedCell.self, for: indexPath)

        if let movie = movies[safe: indexPath.row] {
            cell.movie = movie
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movies[safe: indexPath.row] else { return }
        let detailVC = DetailController(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            print("load more!")
            loadMoreMovieData(by: searchOption)
        }
    }
}
