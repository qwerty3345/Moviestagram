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

    private let movieRemoteRepository: MovieAPIRepositoryProtocol

    // MARK: - Lifecycle

    init(movieRemoteRepository: MovieAPIRepositoryProtocol) {
        self.movieRemoteRepository = movieRemoteRepository
    }

    // MARK: - Public

    func fetchMovie() {
        Task {
            guard let movies = try await movieRemoteRepository.fetchMovie(with: searchOption) else { return }
            self.movies = movies
        }
    }

    func loadMoreMovieData() {
        Task {
            guard let moreLoadedMovies = try await movieRemoteRepository.fetchMovie(
                with: [searchOption, .page(currentPage + 1)]
            ) else { return }

            self.movies += moreLoadedMovies
        }
    }
}
