//
//  GymTimeCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 6/5/21.
//
//

import Foundation
import CoreData


extension GymTimeCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GymTimeCore> {
        return NSFetchRequest<GymTimeCore>(entityName: "GymTimeCore")
    }

    @NSManaged public var monday_start: String?
    @NSManaged public var tuesday_start: String?
    @NSManaged public var wednesday_start: String?
    @NSManaged public var thursday_start: String?
    @NSManaged public var friday_start: String?
    @NSManaged public var saturday_start: String?
    @NSManaged public var sunday_start: String?
    @NSManaged public var monday_close: String?
    @NSManaged public var tuesday_close: String?
    @NSManaged public var wednesday_close: String?
    @NSManaged public var thursday_close: String?
    @NSManaged public var friday_close: String?
    @NSManaged public var saturday_close: String?
    @NSManaged public var sunday_close: String?
    @NSManaged public var gym: GymCore?

}

extension GymTimeCore : Identifiable {

}
