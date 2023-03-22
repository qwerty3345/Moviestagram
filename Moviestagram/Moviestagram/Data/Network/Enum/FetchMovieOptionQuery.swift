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

    var queryString: String {
        switch self {
        case .sortByRating:
            return "sort_by=rating"
        case .sortByLike:
            return "sort_by=like_count"
        case .sortByRecent:
            return "sort_by=date_added"
        case .search(let keyword):
            return "query_term=\(keyword)"
        case .page(let page):
            return "page=\(page)"
        }
    }
}
