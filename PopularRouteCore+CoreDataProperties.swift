//
//  PopularRouteCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//
//

import Foundation
import CoreData


extension PopularRouteCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PopularRouteCore> {
        return NSFetchRequest<PopularRouteCore>(entityName: "PopularRouteCore")
    }

    @NSManaged public var name: String
    @NSManaged public var map: String
    @NSManaged public var distance: Double
    @NSManaged public var length: Double
    @NSManaged public var background: String
    @NSManaged public var intruduction: String
    @NSManaged public var suburb: String
    @NSManaged public var postcode: String
    @NSManaged public var uid: Int16
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var detail_text: String
    @NSManaged public var safety_tips: String
    @NSManaged public var star: Bool

}

extension PopularRouteCore : Identifiable {

}
