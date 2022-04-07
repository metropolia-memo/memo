//
//  TempTaskStepNote.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//
//  Temporary structs to use when developing UI while still Core Data still not functional
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    var date: Date
    var name: String
    var location: String
    var note: String
    var steps: [Step]
    var completed: Bool
    
    init(id: UUID = UUID(), date: Date = Date(), name: String, location: String, note: String, steps: [Step], completed: Bool = false) {
        self.id = id
        self.date = date
        self.name = name
        self.location = location
        self.note = note
        self.steps = steps
        self.completed = completed
    }
    
}

struct Step: Identifiable {
    let id: UUID
    var name: String
    var completed: Bool = false
    
    init(id: UUID = UUID(), name: String, completed: Bool) {
        self.id = id
        self.name = name
        self.completed = completed
    }
}

struct Note: Identifiable {
    let id: UUID
    var sensitive: Bool = false
    var name: String
    var note: String
    var date: Date
    
    init(id: UUID = UUID(), sensitive: Bool, name: String, note: String, date: Date = Date()) {
        self.id = id
        self.name = name
        self.note = note
        self.date = date
    }
}

extension Task {
    static let sampleTasks: [Task] =
    [
        Task(id: UUID(), date: Date(), name: "Clean the house", location: "Home", note: "Get it done!", steps: [
            Step(id: UUID(), name: "Toilet", completed: false),
            Step(id: UUID(), name: "Kitchen", completed: false),
            Step(id: UUID(), name: "Living room", completed: false)
        ], completed: false),
        Task(id: UUID(), date: Date(), name: "Grocery list", location: "Prisma Iso-Omena", note: "", steps: [
            Step(id: UUID(), name: "Milk", completed: false),
            Step(id: UUID(), name: "Porridge", completed: false),
            Step(id: UUID(), name: "Ham", completed: false),
            Step(id: UUID(), name: "Minced meat", completed: false)
        ], completed: false),
        Task(id: UUID(), date: Date(), name: "Project checklist", location: "Karaportti 2", note: "Remember to check with team mates regulary", steps: [
            Step(id: UUID(), name: "Prototype", completed: true),
            Step(id: UUID(), name: "Week 1 Sprint", completed: false),
            Step(id: UUID(), name: "Week 2 Sprint", completed: false),
            Step(id: UUID(), name: "Week 3 Sprint", completed: false),
            Step(id: UUID(), name: "Week 4 Sprint", completed: false),
        ], completed: false),
    ]
    
    // Filter tasks within two days
    static let tasksWithinTwoDays: [Task] = Task.sampleTasks.filter { $0.date < Date().addingTimeInterval(172800)}
}

extension Note {
    static let sampleNotes: [Note] =
    [
        Note(id: UUID(), sensitive: false, name: "Lecture notes, Swift", note: "Lorem ipsum", date: Date()),
        Note(id: UUID(), sensitive: true, name: "Bank info", note: "Lorem ipsum", date: Date()),
        Note(id: UUID(), sensitive: false, name: "Lecture notes, iOS", note: "Lorem ipsum", date: Date()),
        Note(id: UUID(), sensitive: false, name: "Remember this, IMPORTANT!!", note: "Lorem ipsum", date: Date())
    ]
}
