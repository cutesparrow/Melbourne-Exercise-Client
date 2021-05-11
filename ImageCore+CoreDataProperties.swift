//
//  ImageCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//
//

import Foundation
import CoreData


extension ImageCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCore> {
        return NSFetchRequest<ImageCore>(entityName: "ImageCore")
    }

    @NSManaged public var name: String
    @NSManaged public var uid: Int16
    @NSManaged public var gym: GymCore?
    @NSManaged public var popularRoute: PopularRouteCore?

}

extension ImageCore : Identifiable {

}
