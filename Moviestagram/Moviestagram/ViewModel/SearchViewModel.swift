//
//  SearchViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation
import Combine

final class SearchViewModel: MovieListViewModelProtocol {

    // MARK: - Properties

    @Published var movies: [Movie] = []
    @Published var isFailedToSearch: Bool = false

    let searchTextSubject = PassthroughSubject<String, Never>()
    private var bag = Set<AnyCancellable>()

    private let movieRemoteRepository: MovieAPIRepositoryProtocol

    // MARK: - Lifecycle

    init(movieRemoteRepository: MovieAPIRepositoryProtocol) {
        self.movieRemoteRepository = movieRemoteRepository
        bindInputs()
    }

    // MARK: - Private

    private func searchMovie(with keyword: String) {
        Task {
            do {
                let movies = try await movieRemoteRepository.fetchMovie(
                    with: [.search(keyword), .sortByLike]
                )

                guard let movies, !movies.isEmpty else {
                    isFailedToSearch = true
                    return
                }

                self.movies = movies

            } catch {
                isFailedToSearch = true
            }
        }
    }

    private func bindInputs() {
        searchTextSubject
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] keyword in
                self?.searchMovie(with: keyword)
            }
            .store(in: &bag)
    }
}
