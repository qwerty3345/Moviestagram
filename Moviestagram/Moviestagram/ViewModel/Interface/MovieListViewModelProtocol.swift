//
//  MovieListViewModelProtocol.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

protocol MovieListViewModelProtocol {
    var movies: [Movie] { get }
}

extension MovieListViewModelProtocol {
    var numberOfMovies: Int { movies.count }

    func movieForCell(at indexPath: IndexPath) -> Movie? {
        return movies[safe: indexPath.row]
    }
}
