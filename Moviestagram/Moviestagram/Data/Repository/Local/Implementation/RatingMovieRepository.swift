//
//  RatingMovieLocalRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

final class RatingMovieRepository: MovieLocalRepositoryProtocol {
    var movies: [Movie] = []
    let storage: StorageProtocol

    init(storage: StorageProtocol) {
        self.storage = storage
        movies = load()
    }

    func save(movie: Movie) {
        storage.save(movie: movie)
    }

    func remove(movie: Movie) {
        storage.remove(movie: movie)
    }

    func load() -> [Movie] {
        storage.load()
    }
}
