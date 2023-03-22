//
//  CoreDataStorage.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/22.
//

import Foundation
import CoreData

final class CoreDataStorage: StorageProtocol {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    lazy var context = persistentContainer.viewContext
    lazy var entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context)

    func save(movie: Movie) {
        guard let entity else { return }

        let movieEntity = NSManagedObject(entity: entity, insertInto: context)

        movieEntity.setValue(movie.id, forKey: "id")
        movieEntity.setValue(movie.url, forKey: "url")
        movieEntity.setValue(movie.title, forKey: "title")
        movieEntity.setValue(movie.summary, forKey: "summary")
        movieEntity.setValue(movie.backgroundImage, forKey: "backgroundImage")
        movieEntity.setValue(movie.mediumCoverImage, forKey: "mediumCoverImage")
        movieEntity.setValue(movie.rating, forKey: "rating")
        movieEntity.setValue(movie.year, forKey: "year")
        movieEntity.setValue(movie.myRating, forKey: "myRating")
        movieEntity.setValue(movie.id, forKey: "id")

        saveContext()
    }

    func remove(movie: Movie) {
        let movieEntities = load()
        guard let movieEntity = movieEntities.first(where: { $0.id == movie.id }) else { return }

        // TODO: CoreData 삭제 기능 구현
//        context.delete(movieEntity)
    }

    func load() -> [Movie] {
        let request = MovieEntity.fetchRequest()

        do {
            let movieEntities = try context.fetch(request)
            return movieEntities.map { $0.toMovie() }
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    private func saveContext() {
        // ✨ 알아서 context에 들어간 내용을 save! 시켜줌
        do {
            try context.save()
            print("저장 완료")
        } catch {
            print(error.localizedDescription)
        }
    }
}
