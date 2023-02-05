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
        setNavigationBarTitle(with: "Movies")
        fetchMovie()
    }

    // MARK: - API
    func fetchMovie() {
        MovieRepository.shared.fetchMovie(with: .sortByLike) { result in
            switch result {
            case .success(let movies):
                self.updateTableView(with: movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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

    private func updateTableView(with movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableView.reloadData(with: .transitionCrossDissolve)
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
}
