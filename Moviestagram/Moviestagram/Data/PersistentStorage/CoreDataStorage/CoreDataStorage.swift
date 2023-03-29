//
//  CoreDataStorage.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/22.
//

import Foundation
import CoreData

final class CoreDataStorage: StorageProtocol {

    // MARK: - Properties

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    lazy var context = persistentContainer.viewContext
    lazy var entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context)

    private let key: String

    init(key: String) {
        self.key = key
    }

    // MARK: - Public

    func save(movie: Movie) {
        let movies = load()

        guard movies.firstIndex(where: { $0.id == movie.id}) == nil else {
            update(movie: movie)
            return
        }

        guard let entity else { return }

        let movieEntity = NSManagedObject(entity: entity, insertInto: context)

        movieEntity.setValuesForKeys([
            "key": key,
            "id": movie.id,
            "url": movie.url,
            "title": movie.title,
            "summary": movie.summary,
            "backgroundImage": movie.backgroundImage,
            "mediumCoverImage": movie.mediumCoverImage,
            "rating": movie.rating,
            "year": movie.year,
            "myRating": movie.myRating ?? 0.0
        ])

        saveContext()
    }

    func update(movie: Movie) {
        let entities = loadEntities()
        guard let entity = entities.first(where: { $0.id == movie.id }) else { return }
        entity.setValue(movie.myRating, forKey: "myRating")
        saveContext()
    }

    func remove(movie: Movie) {
        let movieEntities = loadEntities()
        guard let movieEntity = movieEntities.first(where: { $0.id == movie.id }) else { return }

        context.delete(movieEntity)
        saveContext()
    }

    func load() -> [Movie] {
        let request = MovieEntity.fetchRequest()

        do {
            let movieEntities = try context.fetch(request)
            return movieEntities
                .filter { $0.key == key }
                .map { $0.toMovie() }
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    // MARK: - Private

    private func loadEntities() -> [MovieEntity] {
        let request = MovieEntity.fetchRequest()

        do {
            let entities = try context.fetch(request)
            return entities.filter { $0.key == key }
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    private func saveContext() {
        do {
            try context.save()
            print("저장 완료")
        } catch {
            print(error.localizedDescription)
        }
    }
}
