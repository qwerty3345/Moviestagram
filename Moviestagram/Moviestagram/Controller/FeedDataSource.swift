//
//  FeedDataSource.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class FeedDataSource: NSObject, UITableViewDataSource {
    var movies: [Movie] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.isEmpty ? 2 : movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: FeedCell.self, for: indexPath)

        if let movie = movies[safe: indexPath.row] {
            cell.configure(with: movie)
        }

        return cell
    }
}
