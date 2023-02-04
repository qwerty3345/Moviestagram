//
//  MovieRepository.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

final class MovieRepository {

    static let shared = MovieRepository()
    private init() { }

    typealias MovieNetworkingCompletion = (Result<[Movie], NetworkError>) -> Void

    func fetchMovie(completion: @escaping MovieNetworkingCompletion) {
        let urlString = "https://yts.mx/api/v2/list_movies.json"

        performRequest(with: urlString, completion: completion)
    }

    private func performRequest(with urlString: String, completion: @escaping MovieNetworkingCompletion) {
        guard let url = URL(string: urlString) else { return }
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
