//
//  MovieRemoteRepositoryProtocol.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

protocol MovieAPIRepositoryProtocol {

    // MARK: - Properties

    var service: NetworkService { get }
    var baseURLString: String { get }

    // MARK: - Method

    func fetchMovie(with options: [FetchMovieOptionQuery]) async throws -> [Movie]?
}

extension MovieAPIRepositoryProtocol {
    func fetchMovie(with option: FetchMovieOptionQuery) async throws -> [Movie]? {
        try await fetchMovie(with: [option])
    }
}
