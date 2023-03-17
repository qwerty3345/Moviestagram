//
//  SearchViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class SearchViewModel: MovieListViewModelProtocol {
    // MARK: - Properties
    @Published var movies: [Movie] = []
    @Published var networkError: NetworkError? = nil

    private let movieRemoteRepository: MovieRemoteRepositoryProtocol

    init(movieRemoteRepository: MovieRemoteRepositoryProtocol) {
        self.movieRemoteRepository = movieRemoteRepository
    }

    // MARK: - API
    func searchMovie(with keyword: String) {
        Task {
            guard let movies = try await movieRemoteRepository.fetchMovie(with: [.search(keyword), .sortByLike]) else { return }
            self.movies = movies
        }
    }
}
