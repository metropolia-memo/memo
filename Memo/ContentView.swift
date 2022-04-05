//
//  ContentView.swift
//  Memo
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    // @Environment: Accessing the current context set to the SwiftUI environment
    @Environment(\.managedObjectContext) var moc
    
    
    // Making a FetchRequest without any sorting
    // @FetchRequest: fetches data from Core Data.
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    
    var body: some View {
        NavigationView {
            VStack {
                List(tasks) { task in
                    Text(task.name ?? "Unknown task")
                }
                
                // Used for testing CoreData. Creates random tasks and saves them to Core Data. The UI list gets updated according to the current Core Data.
                
                // Remove this button when starting development.
                Button("Add") {
                    let name = ["Do dishes", "Plan meals", "Homework", "Go for a run"]
                    let date = Date()
                    
                    let rndName = name.randomElement()
                    let newTask = Task(context: moc)
                    newTask.id = UUID()
                    newTask.name = rndName
                    newTask.deadline = date
                    
                    try? moc.save()
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
