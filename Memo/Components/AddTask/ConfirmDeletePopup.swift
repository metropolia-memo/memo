//
//  ConfirmDeletePopup.swift
//  Memo
//
//  Created by iosdev on 14.4.2022.
//

import SwiftUI

// Handles the deletion of the selected object depending on it being a Step or Task.
struct ConfirmDeletePopup: View {
    
    @Binding var display : Bool
    @Binding var addedSteps : [Step]
    @Binding var step : Step?
    @Binding var task : Task?
    
    
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
            // Remove from Core Data
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
                                    
                        }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                
                        // Creates a new Step object and adds it to the addSteps list in AddTaskView. After this, navigate back.
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            deleteItem()
                            display = false
                        }}) {
                            Text("Delete")
                                    .foregroundColor(Color.white)
                        }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                
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
        ConfirmDeletePopup(display: .constant(true), addedSteps: .constant([Step()]), step: .constant(Step()), task: .constant(nil))
    }
}
