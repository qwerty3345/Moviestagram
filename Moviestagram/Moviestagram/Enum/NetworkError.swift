//
//  NetworkError.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

enum NetworkError: LocalizedError {
    case networkingError
    case dataError
    case parseError

    var errorDescription: String? {
        switch self {
        case .networkingError:
            return "네트워크를 연결하는데 실패했습니다."
        case .dataError:
            return "데이터를 가져오는데 실패했습니다."
        case .parseError:
            return "데이터를 파싱하는데 실패했습니다."
        }
    }
}
