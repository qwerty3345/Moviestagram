//
//  MovieLocalRepositoryProtocol.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/03.
//

import Foundation

protocol MovieLocalRepositoryProtocol: AnyObject {
    var movies: [Movie] { get set }
    var storage: StorageProtocol { get }

    func save(movie: Movie)
    func remove(movie: Movie)
    func load() -> [Movie]
}