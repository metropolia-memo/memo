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
    @State var task : Task?
    @State var editingTask = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack {

                MapView()
                
                if (editingTask) {
                    AddTaskView(editingTask: $editingTask, editableTask: $task, moc: moc)
                }
                
                if (!editingTask) {
                    HStack {
                        Button(action: {editingTask = true}) {
                            Text("Toggle edit view")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                        .background(Color.blue)
                    }
                }
              
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
             if (editingTask) {
                 editingTask = false
                 return
             }
                self.presentationMode.wrappedValue.dismiss()
      
            }) {
             Image(systemName: "chevron.left")
                 .foregroundColor(Color.blue)
                 .scaleEffect(1)
            })
    }
}

//struct Tasks_Previews: PreviewProvider {
//    static var previews: some View {
//        Tasks()
//    }
//}
