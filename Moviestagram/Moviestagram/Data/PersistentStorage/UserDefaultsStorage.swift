//
//  UserDefaultsStorage.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/22.
//

import Foundation

final class UserDefaultsStorage: StorageProtocol {

    // MARK: - Properties

    private let key: String
    private let userDefaults: UserDefaults

    // MARK: - Lifecycle

    init(key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.userDefaults = userDefaults
    }

    // MARK: - Public

    func save(movie: Movie) {
        var movies = load()

        guard movies.firstIndex(where: { $0.id == movie.id}) == nil else {
            update(movie: movie)
            return
        }

        movies.append(movie)
        save(movies: movies)
    }

    func load() -> [Movie] {
        guard let data = userDefaults.value(forKey: key) as? Data,
              let loadedMovies = try? PropertyListDecoder().decode([Movie].self, from: data) else { return [] }
        return loadedMovies
    }

    func update(movie: Movie) {
        var movies = load()

        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else { return }
        movies[index] = movie

        save(movies: movies)
    }

    func remove(movie: Movie) {
        var movies = load()

        if let index = movies.firstIndex(where: { $0.id == movie.id}) {
            movies.remove(at: index)
            save(movies: movies)
        }
    }

    // MARK: - Private

    private func save(movies: [Movie]) {
        let value = try? PropertyListEncoder().encode(movies)
        userDefaults.setValue(value, forKey: key)
    }

}
