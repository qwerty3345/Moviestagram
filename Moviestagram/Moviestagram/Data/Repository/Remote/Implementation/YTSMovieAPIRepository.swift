//
//  MovieRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

final class YTSMovieAPIRepository: MovieAPIRepositoryProtocol {

    // MARK: - Properties
    let baseURLString = "https://yts.mx/api/v2/list_movies.json"
    let service: NetworkService

    // MARK: - Lifecycle
    init(service: NetworkService) {
        self.service = service
    }

    // MARK: - Helpers
    func fetchMovie(with options: [FetchMovieOptionQuery]) async throws -> [Movie]? {
        guard let url = movieQueryURL(with: options) else {
            throw NetworkError.networkingError
        }
        let data = try await service.performRequest(with: url)
        let movies = try parseJSON(data)
        return movies
    }

    private func movieQueryURL(with options: [FetchMovieOptionQuery]) -> URL? {
        let urlString = options.reduce("\(baseURLString)?") { partialResult, option in
            "\(partialResult)&\(option.queryString)"
        }
        return URL(string: urlString)
    }

    private func parseJSON(_ movieData: Data) throws -> [Movie]? {
        let movieData = try JSONDecoder().decode(MovieResponse.self, from: movieData)
        return movieData.data.movies
    }
}
