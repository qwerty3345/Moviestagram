//
//  MovieResponse.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Decodable {
    let status, statusMessage: String
    let movieData: MovieData

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case movieData = "data"
    }
}

// MARK: - MovieData
struct MovieData: Decodable {
    let movieCount, limit: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case limit
        case movies
    }
}
