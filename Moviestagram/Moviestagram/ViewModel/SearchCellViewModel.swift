//
//  SearchCellViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/12.
//

import Foundation

final class SearchCellViewModel {

    // MARK: - Properties

    private let movie: Movie

    var posterImageURLString: String? {
        movie.mediumCoverImage
    }
    var titleLabelText: String? {
        movie.title
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
