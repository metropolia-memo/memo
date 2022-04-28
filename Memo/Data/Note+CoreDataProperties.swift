//
//  Note+CoreDataProperties.swift
//  Memo
//
//  Created by Markus Nivasalo on 20.4.2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String
    @NSManaged public var id: UUID
    @NSManaged public var isSensitive: Bool
    @NSManaged public var date_added: Date
    @NSManaged public var note_text: String

}

extension Note : Identifiable {

}
