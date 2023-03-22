//
//  BookmarkMovieLocalRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

final class BookmarkMovieLocalRepository: MovieLocalRepositoryProtocol {
    let key = "bookmark_movie"
    var movies: [Movie] = []

    init() {
        movies = load()
    }
}
