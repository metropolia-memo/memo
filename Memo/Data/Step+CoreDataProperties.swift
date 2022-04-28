//
//  Step+CoreDataProperties.swift
//  Memo
//
//  Created by iosdev on 6.4.2022.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var origin: Task?
    
}

extension Step : Identifiable {
    
    public var wrappedDesc : String {
        desc ?? "Unknown step"
    }
    
}
