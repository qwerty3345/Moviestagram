//
//  MovieEntity+CoreDataProperties.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/22.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "CoreDataStorage")
    }

    @NSManaged public var id: Int64
    @NSManaged public var url: String?
    @NSManaged public var myRating: Float
    @NSManaged public var year: Int64
    @NSManaged public var rating: Double
    @NSManaged public var mediumCoverImage: String?
    @NSManaged public var backgroundImage: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?

}

extension MovieEntity : Identifiable {
    func toMovie() -> Movie {
        return Movie(
            id: Int(self.id),
            url: self.url ?? "",
            title: self.title ?? "",
            summary: self.summary ?? "",
            backgroundImage: self.backgroundImage ?? "",
            mediumCoverImage: self.mediumCoverImage ?? "",
            rating: self.rating,
            year: Int(self.year),
            myRating: self.myRating
        )
    }
}
