//
//  TaskLocation+CoreDataProperties.swift
//  Memo
//
//  Created by Oskari Arponen on 19.4.2022.
//
//

import Foundation
import CoreData


extension TaskLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskLocation> {
        return NSFetchRequest<TaskLocation>(entityName: "TaskLocation")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var taskLocation: Task?
    @NSManaged public var id: UUID

}

extension TaskLocation : Identifiable {

    
}
