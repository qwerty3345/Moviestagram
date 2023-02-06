//
//  FeedViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class FeedViewModel {
    private(set) var movies: Observable<[Movie]> = Observable([])
    private var currentPage: Int { movies.value.count / 20 }

    var searchOption: FetchMovieOptionQuery = .sortByLike {
        didSet { fetchMovie() }
    }

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
