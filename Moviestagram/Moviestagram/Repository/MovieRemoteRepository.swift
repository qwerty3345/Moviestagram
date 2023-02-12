//
//  MovieRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

final class MovieRemoteRepository {

    // MARK: - Properties
    static let shared = MovieRemoteRepository()
    private let baseURLString = "https://yts.mx/api/v2/list_movies.json"

    private init() { }

    // MARK: - Helpers
    // TODO: 페이지 별로 로딩해서 띄우게도 구현...!
    func fetchMovie(with options: [FetchMovieOptionQuery]) async throws -> [Movie] {
        guard let url = movieQueryURL(with: options) else {
            throw NetworkError.networkingError
        }
        let movies = try await performRequest(with: url)
        return movies
    }

    func fetchMovie(with option: FetchMovieOptionQuery) async throws -> [Movie] {
        guard let url = movieQueryURL(with: [option]) else {
            throw NetworkError.networkingError
        }
        let movies = try await performRequest(with: url)
        return movies
    }

    private func movieQueryURL(with options: [FetchMovieOptionQuery]) -> URL? {
        let urlString = options.reduce("\(baseURLString)?") { partialResult, option in
            "\(partialResult)&\(option.queryString)"
        }
        return URL(string: urlString)
    }

    private func performRequest(with url: URL) async throws -> [Movie] {
        let session = URLSession(configuration: .default)
        let (data, response) = try await session.data(from: url)

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              (200...299) ~= statusCode else {
            throw NetworkError.networkingError
        }

        guard let movies = try parseJSON(data) else {
            throw NetworkError.parseError
        }

        return movies
    }

    private func parseJSON(_ movieData: Data) throws -> [Movie]? {
        let movieData = try JSONDecoder().decode(MovieResponse.self, from: movieData)
        return movieData.data.movies
    }
}
