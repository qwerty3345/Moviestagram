//
//  BookmarkMovieLocalRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

final class BookmarkMovieRepository: MovieLocalRepositoryProtocol {

    // MARK: - Properties

    let storage: StorageProtocol

    // MARK: - Lifecycle

    init(storage: StorageProtocol) {
        self.storage = storage
    }

    // MARK: - Public

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
