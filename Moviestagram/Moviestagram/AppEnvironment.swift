//
//  AppEnvironment.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

final class AppEnvironment {
    lazy var movieRemoteRepository: MovieRemoteRepositoryProtocol = MovieRemoteRepository()
    lazy var bookmarkMovieLocalRepository: MovieLocalRepositoryProtocol = BookmarkMovieLocalRepository()
    lazy var ratingMovieLocalRepository: MovieLocalRepositoryProtocol = RatingMovieLocalRepository()
}
