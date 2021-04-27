//
//  SensorMarkCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//
//

import Foundation
import CoreData


extension SensorMarkCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SensorMarkCore> {
        return NSFetchRequest<SensorMarkCore>(entityName: "SensorMarkCore")
    }

    @NSManaged public var uid: Int16
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var risk: String?

}

extension SensorMarkCore : Identifiable {

}
