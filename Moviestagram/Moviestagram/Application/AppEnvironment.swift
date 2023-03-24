//
//  AppEnvironment.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

final class AppEnvironment {
    lazy var movieAPIService = NetworkService(session: .shared)
    lazy var movieRemoteRepository: MovieAPIRepositoryProtocol = YTSMovieAPIRepository(
        service: movieAPIService
    )

//    lazy var bookmarkStorage: StorageProtocol = UserDefaultsStorage(key: "bookmark_movie")
    lazy var bookmarkStorage: StorageProtocol = CoreDataStorage(key: "bookmark_movie")
    lazy var bookmarkMovieLocalRepository: MovieLocalRepositoryProtocol = BookmarkMovieRepository(
        storage: bookmarkStorage
    )

//    lazy var ratingStorage: StorageProtocol = UserDefaultsStorage(key: "rating_movie")
    lazy var ratingStorage: StorageProtocol = CoreDataStorage(key: "rating_movie")
    lazy var ratingMovieLocalRepository: MovieLocalRepositoryProtocol = RatingMovieRepository(
        storage: ratingStorage
    )
}
