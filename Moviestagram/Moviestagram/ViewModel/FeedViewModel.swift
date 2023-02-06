//
//  FeedViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class FeedViewModel {
    // MARK: - Properties
    private(set) var movies: Observable<[Movie]> = Observable([])
    var numberOfMovies: Int { movies.value.count }
    private var currentPage: Int { movies.value.count / 20 }

    var searchOption: FetchMovieOptionQuery = .sortByLike {
        didSet { fetchMovie() }
    }

    // MARK: - Helpers
    func movieForCell(at indexPath: IndexPath) -> Movie? {
        return movies.value[safe: indexPath.row]
    }

    // MARK: - API
    func fetchMovie() {
        MovieRemoteRepository.shared.fetchMovie(with: searchOption) { result in
            switch result {
            case .success(let movies):
                self.movies.value = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func loadMoreMovieData() {
        MovieRemoteRepository.shared.fetchMovie(with: [searchOption, .page(currentPage + 1)]) { result in
            switch result {
            case .success(let movies):
                self.movies.value += movies 
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
