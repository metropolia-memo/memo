//
//  HomeFooterView.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//

import SwiftUI

struct HomeFooterView: View {
    
    // Boolean for showing either tasks or notes
    // Tasks == true, Notes == false
    @State private var taskOrNote: Bool = false
    var body: some View {
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
                        ForEach(Task.sampleTasks) { task in
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
                            .background((task.id == Task.sampleTasks[0].id ? Color.accentColor : Color.cyan))
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
                    let nextTwoDays = Date().addingTimeInterval(172800)
                    let comingTasks = Task.sampleTasks.filter { $0.date < nextTwoDays}
                    Text("Upcoming tasks")
                        .font(.largeTitle)
                    ScrollView {
                        LazyVStack {
                            ForEach(comingTasks) { task in
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
                            ForEach(Note.sampleNotes) { note in
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
        
        
    }
}

struct HomeFooterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFooterView()
    }
}
