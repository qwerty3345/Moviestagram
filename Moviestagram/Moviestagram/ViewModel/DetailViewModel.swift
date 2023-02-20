//
//  DetailViewModel.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class DetailViewModel {
    // MARK: - Properties
    private(set) var movie: Observable<Movie>
    var isBookmarked = Observable(false)

    lazy var rating: Float = movie.value.myRating ?? 0 {
        didSet {
            guard oldValue != rating else { return }
                saveRatingMovie(with: rating)
        }
    }

    var posterImageURLString: String? {
        movie.value.mediumCoverImage
    }
    var summaryLabelText: String? {
        movie.value.summary
    }
    var ratingLabelAttributedString: NSAttributedString {
        Util.ratingAttributedText(with: movie.value.rating ?? 0.0)
    }
    var yearLabelText: String {
        "\(movie.value.year ?? 0)년 개봉"
    }

    // MARK: - Lifecycle
    init(movie: Movie) {
        self.movie = Observable(movie)
        checkIfUserBookmarkedMovie()
        checkIfUserRatedMovie()
    }

    func checkIfUserRatedMovie() {
        if let ratedMovie = MovieLocalRepository.shared.ratedMovies.first(where: {
            $0.id == movie.value.id
        }) {
            self.movie.value = ratedMovie
        }
    }

    // MARK: - Repository
    func checkIfUserBookmarkedMovie() {
        if MovieLocalRepository.shared.bookmarkedMovies.first(where: {
            $0.id == movie.value.id
        }) != nil {
            isBookmarked.value = true
        }
    }

    func saveRatingMovie(with rating: Float) {
        movie.value.myRating = rating
        guard rating != 0 else {
            MovieLocalRepository.shared.remove(ratingMovie: movie.value)
            return
        }
        MovieLocalRepository.shared.save(ratingMovie: movie.value)
    }

    func tappedBookmark() {
        if isBookmarked.value {
            MovieLocalRepository.shared.remove(bookmarkMovie: movie.value)
            isBookmarked.value = false
        } else {
            MovieLocalRepository.shared.save(bookmarkMovie: movie.value)
            isBookmarked.value = true
        }
    }

}
