//
//  MovieLocalRepositoryProtocol.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

protocol MovieLocalRepositoryProtocol: AnyObject {
    var key: String { get }
    var movies: [Movie] { get set }
    var userDefaults: UserDefaults { get }

    func save(movie: Movie)
    func remove(movie: Movie)
    func load() -> [Movie]
}

extension MovieLocalRepositoryProtocol {
    var userDefaults: UserDefaults { UserDefaults.standard }

    func save(movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id}) {
            movies[index] = movie
        } else {
            movies.append(movie)
        }

        save(movies: movies)
    }

    private func save(movies: [Movie]) {
        let value = try? PropertyListEncoder().encode(movies)
        UserDefaults.standard.setValue(value, forKey: key)
    }

    func remove(movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id}) {
            movies.remove(at: index)
            save(movies: movies)
        }
    }

    func load() -> [Movie] {
        guard let data = userDefaults.value(forKey: key) as? Data,
              let loadedMovies = try? PropertyListDecoder().decode([Movie].self, from: data) else { return [] }
        return loadedMovies
    }
}
