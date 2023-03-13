//
//  Movie.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let url: String?
    let title: String?
    let summary: String?
    let backgroundImage: String?
    let mediumCoverImage: String?
    let rating: Double?
    let year: Int?
    var myRating: Float?

    enum CodingKeys: String, CodingKey {
        case id, url, title, summary
        case backgroundImage = "background_image"
        case mediumCoverImage = "medium_cover_image"
        case rating, year, myRating
    }
}
