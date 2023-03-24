//
//  DetailViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class DetailViewModel {
    // MARK: - Properties

    @Published private(set) var movie: Movie
    @Published var isBookmarked = false

    lazy var rating: Float = movie.myRating ?? 0 {
        didSet {
            guard oldValue != rating else { return }
                saveRatingMovie(with: rating)
        }
    }

    var posterImageURLString: String? {
        movie.mediumCoverImage
    }
    var summaryLabelText: String? {
        movie.summary
    }
    var ratingLabelAttributedString: NSAttributedString {
        StringUtil.ratingAttributedText(with: movie.rating)
    }
    var yearLabelText: String {
        "\(movie.year)년 개봉"
    }

    private let ratingMovieLocalRepository: MovieLocalRepositoryProtocol
    private let bookmarkMovieLocalRepository: MovieLocalRepositoryProtocol

    // MARK: - Lifecycle

    init(
        movie: Movie,
        ratingMovieLocalRepository: MovieLocalRepositoryProtocol,
        bookmarkMovieLocalRepository: MovieLocalRepositoryProtocol
    ) {
        self.movie = movie
        self.ratingMovieLocalRepository = ratingMovieLocalRepository
        self.bookmarkMovieLocalRepository = bookmarkMovieLocalRepository
        checkIfUserBookmarkedMovie()
        checkIfUserRatedMovie()
    }

    // MARK: - Public

    func checkIfUserRatedMovie() {
        if let ratedMovie = ratingMovieLocalRepository.load().first(where: {
            $0.id == movie.id
        }) {
            self.movie = ratedMovie
        }
    }

    func checkIfUserBookmarkedMovie() {
        if bookmarkMovieLocalRepository.load().first(where: {
            $0.id == movie.id
        }) != nil {
            isBookmarked = true
        }
    }

    func saveRatingMovie(with rating: Float) {
        movie.myRating = rating
        guard rating != 0 else {
            ratingMovieLocalRepository.remove(movie: movie)
            return
        }
        ratingMovieLocalRepository.save(movie: movie)
    }

    func tappedBookmark() {
        if isBookmarked {
            bookmarkMovieLocalRepository.remove(movie: movie)
            isBookmarked = false
        } else {
            bookmarkMovieLocalRepository.save(movie: movie)
            isBookmarked = true
        }
    }

}
