//
//  AppEnvironment.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

final class AppEnvironment {
    lazy var movieAPIService = MovieAPIService(session: .shared)
    lazy var movieRemoteRepository: MovieRemoteRepositoryProtocol = MovieRemoteRepository(
        service: movieAPIService
    )
    lazy var bookmarkMovieLocalRepository: MovieLocalRepositoryProtocol = BookmarkMovieLocalRepository()
    lazy var ratingMovieLocalRepository: MovieLocalRepositoryProtocol = RatingMovieLocalRepository()
}
