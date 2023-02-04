//
//  FeedController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - Properties
    private var movies: [Movie] = []

    // MARK: - UI Properties
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink

        configureTableView()
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
        feedTableView.registerCell(cellClass: FeedCell.self)
        feedTableView.dataSource = self

        view.addSubview(feedTableView)
        feedTableView.fillSuperview()

        setTableViewRowHeight()
    }

    private func setTableViewRowHeight() {
        var rowHeight = view.frame.width + 8 + 40 + 8
        rowHeight += 50
        rowHeight += 60
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = rowHeight
    }

    private func updateFeed(with movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.feedTableView.reloadData(with: .transitionCrossDissolve)
        }
    }
}

// MARK: - UITableViewDataSource
extension FeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.isEmpty ? 2 : movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
    }
}
