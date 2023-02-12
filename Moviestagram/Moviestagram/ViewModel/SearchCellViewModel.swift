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
        Util.ratingAttributedText(with: movie.rating ?? 0.0)
    }
    var yearLabelText: String? {
        "\(movie.year ?? 0)년"
    }

    // MARK: - Lifecycle
    init(movie: Movie) {
        self.movie = movie
    }
}
