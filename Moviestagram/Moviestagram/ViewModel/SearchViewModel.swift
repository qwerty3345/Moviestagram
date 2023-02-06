//
//  SearchViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class SearchViewModel {
    // MARK: - Properties
    private(set) var searchedMovies: Observable<[Movie]> = Observable([])
    var numberOfMovies: Int { searchedMovies.value.count }
    var networkError: Observable<NetworkError?> = Observable(nil)

    // MARK: - Helpers
    func movieForCell(at indexPath: IndexPath) -> Movie? {
        return searchedMovies.value[safe: indexPath.row]
    }

    // MARK: - API
    func searchMovie(with keyword: String) {
        MovieRemoteRepository.shared.fetchMovie(with: [.search(keyword), .sortByLike]) { result in
            switch result {
            case .success(let movies):
                self.searchedMovies.value = movies
            case .failure(let error):
                self.networkError.value = error
            }
        }
    }
}
