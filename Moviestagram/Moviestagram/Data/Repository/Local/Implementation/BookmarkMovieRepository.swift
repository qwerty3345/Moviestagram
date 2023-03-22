//
//  BookmarkMovieLocalRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

final class BookmarkMovieRepository: MovieLocalRepositoryProtocol {
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
