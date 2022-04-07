//
//  AddTaskView.swift
//  Memo
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI

struct AddTaskView: View {
    
    @State private var taskTitle = ""
    @State private var taskDescription = ""
    @State private var taskDeadline = Date()
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            Section(header: Text("Add new task")) {
                
                Section {
                    TextField("Task title", text: $taskTitle)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 5)
           
                
                Section {
                    TextField("Task description", text: $taskDescription)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 5)
              
    
                DatePicker("", selection: $taskDeadline, displayedComponents: [.date, .hourAndMinute])
                    .padding(.trailing, 5)
                    .labelsHidden()
                
                
                Text("Selected date: \(taskDeadline)")
            }
            Button("Save task") {
                let task = Task(context: moc)
                task.name = taskTitle
                task.desc = taskDescription
                task.id = UUID()
     
                // Doesn't do anything right now.
            }
        }
        .background(Color.blue)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
