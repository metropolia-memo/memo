//
//  ConfirmDeletePopup.swift
//  Memo
//
//  Created by Oskari Arponen on 14.4.2022.
//

import SwiftUI
import CoreData

// Handles the deletion of the selected object depending on it being a Step or Task.
struct ConfirmDeletePopup: View {
    
    // Handles displayed status.
    @Binding var display : Bool
    
    // Editing status.
    @Binding var editingTask : Bool
    
    // Accessing the addedSteps list in the AddTaskView.
    @Binding var addedSteps : [Step]
    
    // Possible Step object getting deleted.
    @Binding var step : Step?
    
    // Possible Task object getting deleted.
    @Binding var task : Task?
    
    var moc : NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    // Displays a corresponding message according to the item being a Step or Task.
    func displayMessage() -> String {
        if step != nil {
            return "Delete step '\(step?.desc ?? "unknown")'?"
        } else if task != nil {
            return "Delete task '\(task?.name ?? "unknown")'?"
        }
        return "Not a Step or Task object"
    }
    
    
    // Deletes an item according to the item being a Step or Task.
    func deleteItem() {
        if step != nil {
            addedSteps.remove(at: addedSteps.firstIndex(where: {$0.id == step?.id}) ?? 0)
        } else if task != nil {
        }
    }
    
    
    // Deletes a Task or Step which is being edited.
    func deleteEditableItem() {
        if step != nil {
            addedSteps.remove(at: addedSteps.firstIndex(where: {$0.id == step?.id}) ?? 0)
            moc.delete(step!)
        } else if task != nil {
            moc.delete(task!)
            editingTask = false
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    var body: some View {
        ZStack {
            if display {
                Color.black.opacity(display ? 0.5 : 0).edgesIgnoringSafeArea(.all)
                VStack {
                    VStack(alignment: .leading) {
                        Text(displayMessage())
                            .font(.system(size: 20, weight: .medium))
                            .padding(.top)
                            .padding(.vertical, 20)
                            .font( .system(size: 30, weight: .medium))
                      
                    }
                    .padding()
                         
                    HStack(spacing: 0) {
                        
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            display = false                      }}) {
                            Text("Cancel")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                    .contentShape(Rectangle())
                                    
                        }
                          
                
                        // Creates a new Step object and adds it to the addSteps list in AddTaskView. After this, navigate back.
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            
                            if (editingTask) {
                                deleteEditableItem()
                            } else {
                                deleteItem()
                            }
                            
                            display = false
                        }}) {
                            Text("Delete")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .contentShape(Rectangle())
                        }
                           
                
                    }
                    
                  
          
            }
                .frame(maxWidth: .infinity)
            .background(Color(red: 242/255, green: 242/255, blue: 242/255))
            .cornerRadius(30)
            .shadow(radius: 50)
            .padding()
        }
    }
    }
}

struct ConfirmDeletePopup_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmDeletePopup(display: .constant(true), editingTask: .constant(false), addedSteps: .constant([Step()]), step: .constant(Step()), task: .constant(nil), moc: NSManagedObjectContext())
    }
}
