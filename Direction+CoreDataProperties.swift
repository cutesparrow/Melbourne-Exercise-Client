//
//  Direction+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//
//

import Foundation
import CoreData


extension Direction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Direction> {
        return NSFetchRequest<Direction>(entityName: "Direction")
    }
    
    @NSManaged public var directionSentence: String?
    @NSManaged public var uid: Int16
    @NSManaged public var route: RouteCore?

}

extension Direction : Identifiable {

}
