//
//  MovieRatingRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

final class MovieLocalRepository {
    static let shared = MovieLocalRepository()
    private let ratingKey = "rating_movie"
    private let bookmarkKey = "bookmark_movie"
    private(set) var ratedMovies: [Movie] = []
    private(set) var bookmarkedMovies: [Movie] = []

    private init() {
        ratedMovies = loadRatingMovies()
        bookmarkedMovies = loadBookmarkMovies()
    }

    // MARK: - 영화 별점 평가
    func save(ratingMovie: Movie) {
        if let index = ratedMovies.firstIndex(where: { $0.id == ratingMovie.id}) {
            ratedMovies[index] = ratingMovie
        } else {
            ratedMovies.append(ratingMovie)
        }

        save(ratingMovies: ratedMovies)
    }

    private func save(ratingMovies: [Movie]) {
        let value = try? PropertyListEncoder().encode(ratingMovies)
        UserDefaults.standard.setValue(value, forKey: ratingKey)
    }

    func loadRatingMovies() -> [Movie] {
        guard let data = UserDefaults.standard.value(forKey: ratingKey) as? Data,
              let loadedMovies = try? PropertyListDecoder().decode([Movie].self, from: data) else { return [] }
        return loadedMovies
    }

    // MARK: - 영화 북마크
    func save(bookmarkMovie: Movie) {
        guard bookmarkedMovies.contains(where: { $0.id == bookmarkMovie.id }) == false else { return }
        bookmarkedMovies.append(bookmarkMovie)
        save(bookmarkMovie: bookmarkMovie)
    }

    private func save(bookmarkMovie: [Movie]) {
        let value = try? PropertyListEncoder().encode(bookmarkMovie)
        UserDefaults.standard.setValue(value, forKey: bookmarkKey)
    }

    func loadBookmarkMovies() -> [Movie] {
        guard let data = UserDefaults.standard.value(forKey: bookmarkKey) as? Data,
              let loadedMovies = try? PropertyListDecoder().decode([Movie].self, from: data) else { return [] }
        return loadedMovies
    }
}
