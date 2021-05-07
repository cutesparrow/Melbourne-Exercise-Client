//
//  GymCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 6/5/21.
//
//

import Foundation
import CoreData


extension GymCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GymCore> {
        return NSFetchRequest<GymCore>(entityName: "GymCore")
    }

    @NSManaged public var address: String
    @NSManaged public var classType: String
    @NSManaged public var distance: Double
    @NSManaged public var lat: Double
    @NSManaged public var limitation: Int16
    @NSManaged public var long: Double
    @NSManaged public var name: String
    @NSManaged public var star: Bool
    @NSManaged public var uid: Int16
    @NSManaged public var images: NSSet?
    @NSManaged public var gymTime: GymTimeCore?

}

// MARK: Generated accessors for images
extension GymCore {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageCore)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageCore)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension GymCore : Identifiable {

}
