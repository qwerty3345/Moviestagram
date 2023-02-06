//
//  SearchViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class SearchViewModel {
    private(set) var searchedMovies: Observable<[Movie]> = Observable([])
    var networkError: Observable<NetworkError?> = Observable(nil)

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
