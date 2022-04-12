//
//  ConfirmAddTaskPopup.swift
//  Memo
//
//  Created by iosdev on 12.4.2022.
//

import SwiftUI

struct ConfirmAddTaskPopup: View {
    
    @Binding var display : Bool
    @Binding var taskTitle : String
    var displayToFalse : () -> Void
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
                            displayToFalse()                       }}) {
                            Text("Cancel")
                                    .foregroundColor(Color.white)
                                    
                        }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                
                        // Creates a new Step object and adds it to the addSteps list in AddTaskView. After this, navigate back.
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            saveTaskToCoreData()
                            displayToFalse()
                        }}) {
                            Text("Confirm")
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

struct ConfirmAddTaskPopup_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmAddTaskPopup(display: .constant(true), taskTitle: .constant("Preview title"), displayToFalse: {}, saveTaskToCoreData: {})
    }
}
