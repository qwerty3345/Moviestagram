//
//  NetworkError.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

enum NetworkError: LocalizedError {
    case networking
    case invalidURL
    case invalidData
    case parse

    var errorDescription: String? {
        switch self {
        case .networking:
            return "네트워크를 연결하는데 실패했습니다."
        case .invalidURL:
            return "URL 정보가 잘못되었습니다."
        case .invalidData:
            return "데이터를 가져오는데 실패했습니다."
        case .parse:
            return "데이터를 파싱하는데 실패했습니다. 빈 데이터일 가능성이 있습니다."
        }
    }
}
