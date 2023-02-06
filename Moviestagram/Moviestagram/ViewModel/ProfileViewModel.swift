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
    private(set) var bookmarkedMovies: Observable<[Movie]> = Observable([])
    private(set) var ratedMovies: Observable<[Movie]> = Observable([])
    var numberOfBookmarkedMovies: Int { bookmarkedMovies.value.count }
    var numberOfRatedMovies: Int { ratedMovies.value.count }

    var isRatingListMode: Observable<Bool> = Observable(true)

    // MARK: - Helpers
    func movieForCell(at indexPath: IndexPath) -> Movie? {
        if isRatingListMode.value {
            return ratedMovies.value[safe: indexPath.row]
        } else {
            return bookmarkedMovies.value[safe: indexPath.row]
        }
    }

    // MARK: - API
    func fetchLocalSaveData() {
        ratedMovies.value = MovieLocalRepository.shared.ratedMovies
        bookmarkedMovies.value = MovieLocalRepository.shared.bookmarkedMovies
    }
}

// MARK: - Profile Header
extension ProfileViewModel {
    // MARK: - Properties
    var ratingsLabelText: String { "\(ratedMovies.value.count)\nRating" }
    var bookmarkLabelText: String { "\(bookmarkedMovies.value.count)\nBookmark" }
    var ratingData: [Float: Int] {
        convertRatingData()
    }

    // MARK: - Helpers
    private func convertRatingData() -> [Float: Int] {
        var ratingData: [Float: Int] = [:]
        for movie in ratedMovies.value {
            guard let rating = movie.myRating else { continue }
            ratingData[rating, default: 0] += 1
        }
        return ratingData
    }
}
