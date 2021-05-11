//
//  PopularRouteCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//
//

import Foundation
import CoreData


extension PopularRouteCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PopularRouteCore> {
        return NSFetchRequest<PopularRouteCore>(entityName: "PopularRouteCore")
    }

    @NSManaged public var background: String
    @NSManaged public var detail_text: String
    @NSManaged public var distance: Double
    @NSManaged public var intruduction: String
    @NSManaged public var latitude: Double
    @NSManaged public var length: Double
    @NSManaged public var longitude: Double
    @NSManaged public var map: String
    @NSManaged public var name: String
    @NSManaged public var postcode: String
    @NSManaged public var safety_tips: String
    @NSManaged public var star: Bool
    @NSManaged public var suburb: String
    @NSManaged public var uid: Int16
    @NSManaged public var addedTime: Date?
    @NSManaged public var images: NSSet?

}

// MARK: Generated accessors for images
extension PopularRouteCore {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageCore)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageCore)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension PopularRouteCore : Identifiable {

}
