//
//  FeedViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class FeedViewModel: MovieListViewModelProtocol {
    // MARK: - Properties
    @Published private(set) var movies: [Movie] = []
    private var currentPage: Int {
        movies.count / 20
    }

    var searchOption: FetchMovieOptionQuery = .sortByLike {
        didSet { fetchMovie() }
    }

    private let movieRemoteRepository: MovieRemoteRepositoryProtocol

    init(movieRemoteRepository: MovieRemoteRepositoryProtocol) {
        self.movieRemoteRepository = movieRemoteRepository
    }

    // MARK: - API
    func fetchMovie() {
        Task {
            let movies = try await movieRemoteRepository.fetchMovie(with: searchOption)
            self.movies = movies
        }
    }

    func loadMoreMovieData() {
        Task {
            let moreLoadedMovies = try await movieRemoteRepository.fetchMovie(
                with: [searchOption, .page(currentPage + 1)]
            )

            self.movies += moreLoadedMovies
        }
    }
}
