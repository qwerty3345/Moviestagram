//
//  ProfileHeaderViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import Foundation

struct ProfileHeaderViewModel {
    private var bookmarkedMovies: [Movie]
    private var ratedMovies: [Movie]

    init(bookmarkedMovies: [Movie], ratedMovies: [Movie]) {
        self.bookmarkedMovies = bookmarkedMovies
        self.ratedMovies = ratedMovies
    }

    var ratingsLabelText: String { "\(ratedMovies.count)\nRating" }
    var bookmarkLabelText: String { "\(bookmarkedMovies.count)\nBookmark" }
    var ratingData: [Float: Int] {
        convertRatingData()
    }

    private func convertRatingData() -> [Float: Int] {
        var ratingData: [Float: Int] = [:]
        for movie in ratedMovies {
            guard let rating = movie.myRating else { continue }
            ratingData[rating, default: 0] += 1
        }
        return ratingData
    }
}
