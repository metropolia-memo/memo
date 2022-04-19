//
//  Task+CoreDataProperties.swift
//  Memo
//
//  Created by iosdev on 7.4.2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date_added: Date
    @NSManaged public var deadline: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var steps: NSSet?

}

// MARK: Generated accessors for steps
extension Task {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: Step)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: Step)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

// Creating wrapped values, in order to handle nil coalescing.
extension Task : Identifiable {

    public var wrappedName : String {
        name ?? "Name not found"
    }
    
    public var wrappedDesc : String {
        desc ?? ""
    }
    
    public var wrappedId : UUID {
        id ?? UUID()
    }
    
    public var stepsArray : [Step] {
        let s = steps as? Set<Step> ?? []
        return s.sorted {
            $0.wrappedDesc < $1.wrappedDesc
        }
    }
    
    public var withinTwo : Bool {
        if (deadline != nil) {
            return (deadline! < Date().addingTimeInterval(172800) && deadline! > Date())
        }
        else {
            return false
        }
    }
    
}
