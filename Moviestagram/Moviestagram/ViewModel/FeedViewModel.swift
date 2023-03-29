//
//  FeedViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation
import Combine

final class FeedViewModel: ViewModelType {

    // MARK: - Properties

    final class Input {
        @Published var searchOption: FetchMovieOptionQuery = .sortByLike
    }

    final class Output {
        @Published var movies: [Movie] = []
    }

    let input = Input()
    let output = Output()
    var bag = Set<AnyCancellable>()

    private var currentPage: Int {
        output.movies.count / 20
    }

    var numberOfMovies: Int { output.movies.count }

    func movieForCell(at indexPath: IndexPath) -> Movie? {
        return output.movies[safe: indexPath.row]
    }

    private let movieRemoteRepository: MovieAPIRepositoryProtocol

    // MARK: - Lifecycle

    init(movieRemoteRepository: MovieAPIRepositoryProtocol) {
        self.movieRemoteRepository = movieRemoteRepository

        bindInput()
    }

    // MARK: - Public

    func fetchMovie() {
        Task {
            guard let movies = try await movieRemoteRepository.fetchMovie(with: input.searchOption) else { return }
            self.output.movies = movies
        }
    }

    func loadMoreMovieData() {
        Task {
            guard let moreLoadedMovies = try await movieRemoteRepository.fetchMovie(
                with: [input.searchOption, .page(currentPage + 1)]
            ) else { return }

            self.output.movies += moreLoadedMovies
        }
    }

    // MARK: - Private

    private func bindInput() {
        input.$searchOption
            .sink { [weak self] _ in
                guard let self else { return }
                self.fetchMovie()
            }
            .store(in: &bag)
    }
}
