//
//  NetworkService.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/17.
//

import Foundation

final class NetworkService {

    // MARK: - Properties

    let session: URLSession

    // MARK: - Lifecycle

    init(session: URLSession) {
        self.session = session
    }

    // MARK: - Helpers

    func performRequest(with url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              (200...299) ~= statusCode else {
            throw NetworkError.networkingError
        }

        return data
    }
}
