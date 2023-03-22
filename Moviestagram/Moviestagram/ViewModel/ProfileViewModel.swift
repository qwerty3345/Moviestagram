//
//  ProfileViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

// MARK: - Profile Controller
final class ProfileViewModel {

    // MARK: - Properties

    @Published private(set) var bookmarkedMovies: [Movie] = []
    @Published private(set) var ratedMovies: [Movie] = []

    var numberOfBookmarkedMovies: Int {
        bookmarkedMovies.count
    }
    var numberOfRatedMovies: Int {
        ratedMovies.count
    }

    @Published var listMode: ProfileListMode = .rating

    private let ratingMovieLocalRepository: MovieLocalRepositoryProtocol
    private let bookmarkMovieLocalRepository: MovieLocalRepositoryProtocol

    // MARK: - Lifecycle

    init(
        ratingMovieLocalRepository: MovieLocalRepositoryProtocol,
        bookmarkMovieLocalRepository: MovieLocalRepositoryProtocol
    ) {
        self.ratingMovieLocalRepository = ratingMovieLocalRepository
        self.bookmarkMovieLocalRepository = bookmarkMovieLocalRepository
    }

    // MARK: - Public

    func movieForCell(at indexPath: IndexPath) -> Movie? {
        switch listMode {
        case .rating:
            return ratedMovies[safe: indexPath.row]
        case .bookmark:
            return bookmarkedMovies[safe: indexPath.row]
        }
    }

    func fetchLocalSavedData() {
        ratedMovies = ratingMovieLocalRepository.movies
        bookmarkedMovies = bookmarkMovieLocalRepository.movies
    }
}

// MARK: - Profile Header

extension ProfileViewModel {

    // MARK: - Properties

    var ratingsLabelText: String {
        "\(ratedMovies.count)\nRating"
    }
    var bookmarkLabelText: String {
        "\(bookmarkedMovies.count)\nBookmark"
    }
    var ratingData: [Float: Int] {
        convertRatingData()
    }

    // MARK: - Helpers

    private func convertRatingData() -> [Float: Int] {
        var ratingData: [Float: Int] = [:]
        for movie in ratedMovies {
            guard let rating = movie.myRating else {
                continue
            }
            ratingData[rating, default: 0] += 1
        }
        return ratingData
    }
}
