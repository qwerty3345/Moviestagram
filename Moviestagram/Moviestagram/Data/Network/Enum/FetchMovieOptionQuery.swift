//
//  FetchMovieOptionQuery.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

enum FetchMovieOptionQuery {
    case sortByRating
    case sortByLike
    case sortByRecent
    case search(String)
    case page(Int)

    var urlQueryItem: URLQueryItem {
        switch self {
        case .sortByRating:
            return URLQueryItem(name: "sort_by", value: "rating")
        case .sortByLike:
            return URLQueryItem(name: "sort_by", value: "like_count")
        case .sortByRecent:
            return URLQueryItem(name: "sort_by", value: "date_added")
        case .search(let keyword):
            return URLQueryItem(name: "query_term", value: "\(keyword)")
        case .page(let page):
            return URLQueryItem(name: "page", value: "\(page)")
        }
    }
}
