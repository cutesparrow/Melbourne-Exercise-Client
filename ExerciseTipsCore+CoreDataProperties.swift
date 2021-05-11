//
//  ExerciseTipsCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//
//

import Foundation
import CoreData


extension ExerciseTipsCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseTipsCore> {
        return NSFetchRequest<ExerciseTipsCore>(entityName: "ExerciseTipsCore")
    }

    @NSManaged public var uid: Int16
    @NSManaged public var content: String
    @NSManaged public var tipClass: String

}

extension ExerciseTipsCore : Identifiable {

}
