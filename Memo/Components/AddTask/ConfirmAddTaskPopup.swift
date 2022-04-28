//
//  ConfirmAddTaskPopup.swift
//  Memo
//
//  Created by Oskari Arponen on 12.4.2022.
//

import SwiftUI

// Displays a confirmation window for saving the Task object to Core Data.
struct ConfirmAddTaskPopup: View {
    
    // Handles displayed status.
    @Binding var display : Bool
    
    // Current title of the task.
    @Binding var taskTitle : String
    
    // Saves the task to Core Data.
    var saveTaskToCoreData : () -> Void
    
    var body: some View {
        ZStack {
            if display {
                Color.black.opacity(display ? 0.5 : 0).edgesIgnoringSafeArea(.all)
                VStack {
                    VStack(alignment: .leading) {
                        Text("Save task '\(taskTitle)'?")
                            .font(.system(size: 20, weight: .medium))
                            .padding(.top)
                       
                            .padding(.vertical, 20)
                            .font( .system(size: 30, weight: .medium))
                      
                    }
                    .padding()
               
                    
                    
                    HStack(spacing: 0) {
                        
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            display = false  
                        }}) {
                            Text("Cancel")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                    .contentShape(Rectangle())
                                    
                        }
                       
                
                        // Creates a new Step object and adds it to the addSteps list in AddTaskView. After this, navigate back.
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            saveTaskToCoreData()
                            display = false
                        }}) {
                            Text("Confirm")
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
