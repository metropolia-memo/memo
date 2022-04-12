//
//  HomeFooterView.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//

import SwiftUI

struct HomeFooterView: View {
    @StateObject private var dataController = DataController()
    
    @State private var searchInput: String = ""
    
    // Boolean for showing either tasks or notes
    // Tasks == true, Notes == false
    @State private var taskOrNote: Bool = false
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                HStack {
                    TextField(!taskOrNote ? "Search tasks..." : "Search notes...", text: $searchInput)
                        .textFieldStyle(.roundedBorder)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.accentColor)
                }
                .padding()
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
                            ForEach(TempTask.sampleTasks) { task in
                                VStack(alignment: .leading) {
                                    Image(systemName: "list.bullet.indent")
                                        .frame(width: 50, height: 100)
                                        .scaleEffect(3)
                                    Text("\(task.steps.count) steps")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text("\(task.name)")
                                        .font(.body)
                                        .fontWeight(.bold)
                                }
                                .frame(width: 100)
                                .padding()
                                .background((task.id == TempTask.sampleTasks[0].id ? Color.accentColor : Color.cyan))
                                .foregroundColor(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 5)
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
                                ForEach(TempTask.tasksWithinTwoDays) { task in
                                    VStack(alignment: .leading) {
                                        Text("\(task.name)")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        HStack {
                                            Spacer()
                                            Text("Deadline \(task.date, style: .date)")
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
                    .padding()
                }
                // Lower portion when notes active
                else {
                    VStack {
                        ScrollView {
                            LazyVStack {
                                ForEach(TempNote.sampleNotes) { note in
                                    VStack(alignment: .leading) {
                                        Text("\(note.name)")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        HStack {
                                            Spacer()
                                            Text("Added \(note.date, style: .date)")
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
                        NavigationLink(destination: AddTaskView().environment(\.managedObjectContext, dataController.container.viewContext)) {
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
                        // TODO: Add note button here
                    }
                }
            }
        }
        
        
    }
}

struct HomeFooterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFooterView()
    }
}
