//
//  MovieRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

final class MovieRepository {

    typealias MovieNetworkingCompletion = (Result<[Movie], NetworkError>) -> Void

    // MARK: - Properties
    static let shared = MovieRepository()
    private let baseURLString = "https://yts.mx/api/v2/list_movies.json"

    private init() { }

    // MARK: - Helpers
    // TODO: 페이지 별로 로딩해서 띄우게도 구현...!
    func fetchMovie(with options: [FetchMovieOptionQuery], completion: @escaping MovieNetworkingCompletion) {
        let url = movieQueryURL(with: options)
        performRequest(with: url, completion: completion)
    }

    func fetchMovie(with option: FetchMovieOptionQuery, completion: @escaping MovieNetworkingCompletion) {
        let url = movieQueryURL(with: [option])
        performRequest(with: url, completion: completion)
    }

    private func movieQueryURL(with options: [FetchMovieOptionQuery]) -> URL? {
        let urlString = options.reduce("\(baseURLString)?") { partialResult, option in
            "\(partialResult)&\(option.queryString)"
        }
        return URL(string: urlString)
    }

    private func performRequest(with url: URL?, completion: @escaping MovieNetworkingCompletion) {
        guard let url else { return }
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(.failure(.networkingError))
                return
            }

            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }

            if let movies = self.parseJSON(safeData) {
                completion(.success(movies))
            } else {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }

    private func parseJSON(_ movieData: Data) -> [Movie]? {
        do {
            let movieData = try JSONDecoder().decode(MovieResponse.self, from: movieData)
            return movieData.data.movies
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
