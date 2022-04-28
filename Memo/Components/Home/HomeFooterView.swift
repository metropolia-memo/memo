//
//  HomeFooterView.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//

import SwiftUI
import CoreData

struct HomeFooterView: View {
    @StateObject private var dataController = DataController()

    @Environment(\.managedObjectContext) var moc
    
    var tasks: FetchedResults<Task>
    var notes: FetchedResults<Note>
    
    // Boolean for showing either tasks or notes
    // Tasks == true, Notes == false
    @State private var taskOrNote: Bool = false
    
    @State private var displayLocationWindow = false
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                HStack {
                    Spacer()
                    Button(action: { taskOrNote = false }, label: {
                        Text("Tasks")
                            .font(.title)
                    })
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(!taskOrNote ? Color.accentColor : Color.cyan)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                    Spacer()
                    Button(action: { taskOrNote = true }, label: {
                        Text("Notes")
                            .font(.title)
                    })
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(taskOrNote ? Color.accentColor : Color.cyan)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                    Spacer()
                        
                }
                // Lower portion with tasks active
                if !taskOrNote {
                    ScrollView (.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(tasks) { task in
                                if (task == tasks[0]) {
                                    NavigationLink(destination: Tasks(moc: moc, task: task).environment(\.managedObjectContext, dataController.container.viewContext)) {
                                        TaskRow(task: task, tasks: tasks, first: true)
                                    }
                                        
                                } else {
                                    NavigationLink(destination: Tasks(moc: moc, task: task).environment(\.managedObjectContext, dataController.container.viewContext)) {
                                        TaskRow(task: task, tasks: tasks, first: false)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(height: 200)
                    VStack (alignment: .leading){
                        // Lists all the tasks that have deadline within two days
                        Text("Upcoming tasks")
                            .font(.system(size: 28))
                        ScrollView {
                            LazyVStack {
                                let withinTwo = (tasks.filter {$0.withinTwo}).sorted(by: {$0.date_added < $1.date_added})
                                if (withinTwo.isEmpty) {
                                    Text("No upcoming tasks within the next 48 hours.")
                                        .font(.caption)
                                } else {
                                    ForEach(withinTwo) { task in
                                        NavigationLink(destination: Tasks(moc: moc, task: task).environment(\.managedObjectContext, dataController.container.viewContext)) {
                                            UpcomingTaskRow(task: task)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                // Lower portion when notes active
                else {
                    VStack {
                        ScrollView {
                            LazyVStack {
                                ForEach(notes) { note in
                                    NavigationLink(destination: NoteView(moc: moc, note: note).environment(\.managedObjectContext, dataController.container.viewContext)) {
                                        VStack(alignment: .leading) {
                                            Text("\(note.title)")
                                                .font(.title)
                                                .fontWeight(.bold)
                                            HStack {
                                                Spacer()
                                                Text("Added \(note.date_added, style: .date)")
                                                    .font(.caption)
                                            }
                                        }
                                        .padding()
                                        .background(Color.accentColor)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                        Spacer()
                                    }
                                }
                            }
                            
                            
                        }
                    }
                    .padding()
                }
            }
            // Buttons for adding tasks and notes
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    // Add task button
                    if !taskOrNote {
                        NavigationLink(destination: AddTaskView(displayLocationWindow: $displayLocationWindow, editingTask: .constant(false), editableTask: .constant(nil), moc: moc)) {
                            ZStack {
                                Circle()
                                    .fill(Color.cyan)
                                    .frame(width: 75, height: 75)
                                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                                Text("+")
                                    .foregroundColor(Color.white)
                                    .font(.title)
                            }
                            .padding([.bottom, .trailing], 20)
                            .frame(width: 75, height: 75)
                                
                        }
                    }
                    // Add note button
                    else {
                        NavigationLink(destination: AddNoteView(moc: moc).environment(\.managedObjectContext, dataController.container.viewContext)) {
                            ZStack {
                                Circle()
                                    .fill(Color.cyan)
                                    .frame(width: 75, height: 75)
                                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                                Text("+")
                                    .foregroundColor(Color.white)
                                    .font(.title)
                            }
                            .padding([.bottom, .trailing], 20)
                            .frame(width: 75, height: 75)
                                
                        }
                    }
                }
            }
        }
        
        
    }
}

//struct HomeFooterView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFooterView()
//    }
//}
