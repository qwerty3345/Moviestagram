//
//  MovieRemoteRepositoryProtocol.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

protocol MovieRemoteRepositoryProtocol {
    var baseURLString: String { get }
    func fetchMovie(with options: [FetchMovieOptionQuery]) async throws -> [Movie]
}

extension MovieRemoteRepositoryProtocol {
    func fetchMovie(with option: FetchMovieOptionQuery) async throws -> [Movie] {
        try await fetchMovie(with: [option])
    }
}
