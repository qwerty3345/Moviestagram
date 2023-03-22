//
//  RatingMovieLocalRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

final class RatingMovieLocalRepository: MovieLocalRepositoryProtocol {
    let key = "rating_movie"
    var movies: [Movie] = []

    init() {
        movies = load()
    }
}
