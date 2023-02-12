//
//  FeedViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class FeedViewModel: MovieListViewModelProtocol {
    // MARK: - Properties
    private(set) var movies: Observable<[Movie]> = Observable([])
    private var currentPage: Int {
        movies.value.count / 20
    }

    var searchOption: FetchMovieOptionQuery = .sortByLike {
        didSet { fetchMovie() }
    }

    // MARK: - API
    func fetchMovie() {
        Task {
            let movies = try await MovieRemoteRepository.shared.fetchMovie(with: searchOption)
            self.movies.value = movies
        }
//        MovieRemoteRepository.shared.fetchMovie(with: searchOption) { result in
//            switch result {
//            case .success(let movies):
//                self.movies.value = movies
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }

    func loadMoreMovieData() {
        Task {
            let moreLoadedMovies = try await MovieRemoteRepository.shared.fetchMovie(
                with: [searchOption, .page(currentPage + 1)]
            )

            self.movies.value += moreLoadedMovies
        }
//        MovieRemoteRepository.shared.fetchMovie(with: [searchOption, .page(currentPage + 1)]) { result in
//            switch result {
//            case .success(let movies):
//                self.movies.value += movies
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}
