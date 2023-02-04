//
//  MovieResponse.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

// MARK: - ApiResponse
struct MovieResponse: Codable {
    let status, statusMessage: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let movieCount, limit: Int?
    let movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case limit
        case movies
    }
}
