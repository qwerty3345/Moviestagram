//
//  ProfileViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class ProfileViewModel {
    private(set) var bookmarkedMovies: Observable<[Movie]> = Observable([])
    private(set) var ratedMovies: Observable<[Movie]> = Observable([])

    var isRatingListMode: Observable<Bool> = Observable(true)
    func movieForCell(at indexPath: IndexPath) -> Movie? {
        if isRatingListMode.value {
            return ratedMovies.value[safe: indexPath.row]
        } else {
            return bookmarkedMovies.value[safe: indexPath.row]
        }
    }

    func fetchLocalSaveData() {
        ratedMovies.value = MovieLocalRepository.shared.ratedMovies
        bookmarkedMovies.value = MovieLocalRepository.shared.bookmarkedMovies
    }

    // MARK: - Profile Header 관련
    var ratingsLabelText: String { "\(ratedMovies.value.count)\nRating" }
    var bookmarkLabelText: String { "\(bookmarkedMovies.value.count)\nBookmark" }
    var ratingData: [Float: Int] {
        convertRatingData()
    }

    private func convertRatingData() -> [Float: Int] {
        var ratingData: [Float: Int] = [:]
        for movie in ratedMovies.value {
            guard let rating = movie.myRating else { continue }
            ratingData[rating, default: 0] += 1
        }
        return ratingData
    }
}
