//
//  RouteCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 6/5/21.
//
//

import Foundation
import CoreData


extension RouteCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RouteCore> {
        return NSFetchRequest<RouteCore>(entityName: "RouteCore")
    }

    @NSManaged public var length: Double
    @NSManaged public var mapImage: String?
    @NSManaged public var risk: String?
    @NSManaged public var time: String?
    @NSManaged public var type: String?
    @NSManaged public var polyline: String?
    @NSManaged public var directions: NSSet?

}

// MARK: Generated accessors for directions
extension RouteCore {

    @objc(addDirectionsObject:)
    @NSManaged public func addToDirections(_ value: Direction)

    @objc(removeDirectionsObject:)
    @NSManaged public func removeFromDirections(_ value: Direction)

    @objc(addDirections:)
    @NSManaged public func addToDirections(_ values: NSSet)

    @objc(removeDirections:)
    @NSManaged public func removeFromDirections(_ values: NSSet)

}

extension RouteCore : Identifiable {

}
