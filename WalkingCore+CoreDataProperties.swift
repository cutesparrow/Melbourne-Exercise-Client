//
//  WalkingCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//
//

import Foundation
import CoreData


extension WalkingCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WalkingCore> {
        return NSFetchRequest<WalkingCore>(entityName: "WalkingCore")
    }

    @NSManaged public var length: Double
    @NSManaged public var mapImage: String
    @NSManaged public var polyline: String
    @NSManaged public var risk: String
    @NSManaged public var showName: String
    @NSManaged public var time: String
    @NSManaged public var type: String
    @NSManaged public var uid: Int16
    @NSManaged public var like: Bool

}

extension WalkingCore : Identifiable {

}
