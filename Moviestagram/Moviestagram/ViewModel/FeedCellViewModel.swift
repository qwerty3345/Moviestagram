//
//  FeedCellViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/12.
//

import Foundation

final class FeedCellViewModel {

    // MARK: - Properties

    private let movie: Movie

    var movieTitleButtonText: String? {
        movie.title
    }
    var profileImageURLString: String? {
        movie.backgroundImage
    }
    var posterImageURLString: String? {
        movie.mediumCoverImage
    }
    var summaryLabelText: String? {
        movie.summary
    }
    var ratingLabelText: NSAttributedString {
        StringUtil.ratingAttributedText(with: movie.rating)
    }
    var yearLabelText: String? {
        "\(movie.year)년"
    }

    // MARK: - Lifecycle

    init(movie: Movie) {
        self.movie = movie
    }
}
