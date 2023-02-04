//
//  FeedController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class FeedController: UITableViewController {
    // MARK: - Properties
    private var movies: [Movie] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavigationBar()
        fetchMovie()
    }

    // MARK: - API
    func fetchMovie() {
        MovieRepository.shared.fetchMovie { result in
            switch result {
            case .success(let movies):
                self.updateFeed(with: movies)
                print(movies.first)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Helpers
    private func configureTableView() {
        tableView.registerCell(cellClass: FeedCell.self)
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.allowsSelection = false

        setTableViewRowHeight()
    }

    private func configureNavigationBar() {
        navigationItem.title = "Movies"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.customFont(name: .rachel, size: 24)
        ]
    }

    private func setTableViewRowHeight() {
        var rowHeight = view.frame.width + 8 + 40 + 8
        rowHeight += 50
        rowHeight += 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = rowHeight
    }

    private func updateFeed(with movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableView.reloadData(with: .transitionCrossDissolve)
        }
    }

    private func moveToDetailController(with movie: Movie) {
        // TODO: 자세한 영화 소개 화면으로 이동
    }
}

// MARK: - UITableViewDataSource
extension FeedController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.isEmpty ? 2 : movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: FeedCell.self, for: indexPath)
        cell.delegate = self

        if let movie = movies[safe: indexPath.row] {
            cell.movie = movie
        }

        return cell
    }
}

// MARK: - FeedCellDelegate
extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowMovieDetailFor movie: Movie) {
        moveToDetailController(with: movie)
    }
}
