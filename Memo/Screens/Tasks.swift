//
//  Tasks.swift
//  Memo
//
//  Created by iosdev on 21.4.2022.
//

import SwiftUI
import CoreData

struct Tasks: View {
    
    var moc : NSManagedObjectContext
    @ObservedObject var updatedTask : Task
    @State var task : Task?
    @State var editingTask = false
    @State var displayLocationWindow = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack {

                MapView(task: $task)
                SlideUp(task: updatedTask, moc: moc)
                
                if (editingTask) {
                    AddTaskView(displayLocationWindow: $displayLocationWindow, editingTask: $editingTask, editableTask: $task, moc: moc)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                if (displayLocationWindow) {
                    displayLocationWindow = false
                    return
                } else if (editingTask) {
                     editingTask = false
                     return
                 }
                    self.presentationMode.wrappedValue.dismiss()

            }) {
             Image(systemName: "chevron.left")
                 .foregroundColor(Color.blue)
                 .scaleEffect(1)
            }, trailing: Button(action: {editingTask = true}) {
                if (!editingTask) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color.blue)
                        .scaleEffect(2)
                        .contentShape(Rectangle())
                }
                
            })
    }
}
