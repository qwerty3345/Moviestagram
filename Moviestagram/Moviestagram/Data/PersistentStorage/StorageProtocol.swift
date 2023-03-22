//
//  Storable.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/22.
//

import Foundation

protocol StorageProtocol {
    func save(movie: Movie)
    func remove(movie: Movie)
    func load() -> [Movie]
}
