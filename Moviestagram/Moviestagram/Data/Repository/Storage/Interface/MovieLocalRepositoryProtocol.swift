//
//  MovieLocalRepositoryProtocol.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

protocol MovieLocalRepositoryProtocol: AnyObject {

    // MARK: - Properties

    var storage: StorageProtocol { get }

    // MARK: - Method

    func save(movie: Movie)
    func remove(movie: Movie)
    func load() -> [Movie]
}
