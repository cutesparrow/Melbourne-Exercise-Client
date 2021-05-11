//
//  AboutCovidCore+CoreDataProperties.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/5/21.
//
//

import Foundation
import CoreData


extension AboutCovidCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AboutCovidCore> {
        return NSFetchRequest<AboutCovidCore>(entityName: "AboutCovidCore")
    }

    @NSManaged public var background: String?
    @NSManaged public var color: String?
    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var uid: Int16

}

extension AboutCovidCore : Identifiable {

}
