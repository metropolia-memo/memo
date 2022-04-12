//
//  AddTaskView.swift
//  Memo
//
//  Created by Oskari Arponen on 6.4.2022.
//

import SwiftUI

// Displays components for creating a new task.
struct AddTaskView: View {
    
    @State private var showAlert = false
    @State private var taskTitle = ""
    @State private var taskDeadline = Date()
    @State private var showDateSheet = false
    @State private var showAddStepPopup = false
    
    @State private var showConfirmWindow = false
    @State private var taskDesc = ""
    @State private var currentLocation = ""
    @State private var addedSteps : [Step] = []
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {

                NavigationView {
                    VStack {
                        
                        // Title input
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Title")
                                    .bold()
                                HStack {
                                    TextField("Task title", text: $taskTitle)
                                    Button(action: {}) {
                                        Image(systemName: "pencil")
                                            .font(.system(size: 40))
                                    }
                                
                                }
                               
                            }
                            .padding(15)
                            .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                      
                        }
                        .padding(.horizontal, 5)
                   
                        
                        // Deadline input
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Deadline")
                                    .bold()
                                HStack {
                                    Text(taskDeadline, style: .date)
                                    Text(taskDeadline, style: .time)
                                    Spacer()
                                    Button(action: {withAnimation(.linear(duration: 0.3)) {
                                        showDateSheet.toggle()
                                    }}) {
                                        Image(systemName: "calendar")
                                            .font(.system(size: 40))
                                    }
                                   
                                }
                                .frame(maxWidth: .infinity)
                    
                            }
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(Color(red: 242/255, green: 242/255, blue: 242/255))                            .cornerRadius(15)
                            .shadow(radius: 5)
                            
                            

            
                        }
                        .padding(.horizontal, 5)
               
                        
                        // Location input
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Location")
                                    .bold()
                                HStack {
                                    Text("Karaportti 2")
                                    Spacer()
                                    Button(action: {}) {
                                        Image(systemName: "location.fill")
                                            .font(.system(size: 40))
                                    }
                                
                                }
                               
                            }
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                      
                        }
                        .padding(.horizontal, 5)
                        
                        
                        HStack {
                            Text("Steps")
                    
                                .font( .system(size: 30, weight: .medium))
                            Spacer()
                            Button(action: {showAddStepPopup = true}) {

                                Image(systemName: "plus.circle")
                                    .font(.system(size: 50))
                                  
                            }
                            .padding(.vertical, 5)
                            .frame(maxHeight: .infinity)
                       
                        }
                        .frame(maxHeight: 80)
                        .padding(.horizontal, 10)
                        
                        VStack {
                            if !addedSteps.isEmpty {
                                ScrollView {
                                   
                                    VStack {
           
                                            ForEach(addedSteps) {step in
                                                HStack {
                                                    Image(systemName: "checkmark.circle")
                                                    Text(step.desc ?? "Description not found")
                                                        .padding(5)
                                                    Spacer()
                                                    VStack {
                                                        
                                                    }
                                                    .frame(maxHeight: .infinity)
                                                    .padding(.vertical, 5)
                                                    .padding(.horizontal, 2)
                                                    .background(Color.blue)
                                                }
                        
                                                .frame(
                                                       maxWidth: .infinity,
                                                       maxHeight: 35,alignment: .leading)
                                            
                                                .padding(10)
                                               
                                                .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                             
                                            }
                                    }
                               

                                }
                                .padding(5)
                              
                            } else {
                                VStack {
                                    Text("No steps added")
                                        .font(.system(size: 30))
                                    Image(systemName: "moon.zzz.fill")
                                        .font(.system(size: 50))
                                        .padding(5)
                                        .foregroundColor(Color.gray)
                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                           
                            }

                        
                        }
                        

                        
                        // Note input
                        VStack {
                            Text("Note")
                                .font( .system(size: 30, weight: .medium))
                                .padding(5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack(alignment: .leading) {
                              
                                    TextField("Task description", text: $taskDesc)
      
                               
                            }
                            .padding(15)
                            .frame(maxHeight: .infinity, alignment: .topLeading)
                            .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                            .cornerRadius(15)
                      
                        }
                        .padding(.horizontal, 5)
                        .frame(maxHeight: .infinity)
 
                            Button("Save task") {
                                if (taskTitle == "") {
                                    showAlert = true
                                    return
                                }
                                showConfirmWindow = true
                            }
                            .frame(maxHeight: 50)
                            .padding(.horizontal, 20)
                            .background(taskTitle != "" ? Color(red: 45/255, green: 91/255, blue: 255/255) : Color.gray)
                            .foregroundColor(Color.white)
                        
                        .cornerRadius(10)
                        
                    }
                   
                    .navigationBarTitle("", displayMode: .inline)
                }
                
           
                
            // Displays a DatePicker popup
            DatePickerPopup(display: $showDateSheet, taskDeadline: $taskDeadline, displayToFalse: {showDateSheet = false})
            
            
            // Displays a popup which enables adding steps
            AddStepPopup(display: $showAddStepPopup, displayToFalse: {showAddStepPopup = false}, addStepToList: {step in
                addedSteps.append(step)
            })
            
            
            // Displays a confirmation popup
            ConfirmAddTaskPopup(display: $showConfirmWindow, taskTitle: $taskTitle, displayToFalse: {showConfirmWindow = false}, saveTaskToCoreData: {
                do {
                    // Creates a new Task object with the given State variables and saves it to Core Data.
                    let newTask = Task(context: moc)
                    newTask.name = taskTitle
                    newTask.desc = taskDesc
                    newTask.deadline = taskDeadline
                    newTask.id = UUID()
                    
                    for step in addedSteps {
                        step.origin = newTask
                    }

                    try self.moc.save()
                    
                    print("Task \( newTask) saved succesfully to Core Data.")
                } catch {
                    print("Saving to Core Data failed. \(error)")
                }
                
                
                self.presentationMode.wrappedValue.dismiss()
            })
            
        }
        .alert("Title missing!", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                showAlert = false
            }
        }
        
     
    }
    
}



struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
