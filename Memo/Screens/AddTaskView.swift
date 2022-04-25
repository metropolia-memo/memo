//
//  AddTaskView.swift
//  Memo
//
//  Created by Oskari Arponen on 6.4.2022.
//

import SwiftUI
import CoreData

// Displays components for creating a new task.
struct AddTaskView: View {
    
    // Used in DatePickerPopup, AddStepPopup and for displaying an error alert if the user lacks a title input.
    @State private var showAlert = false
    @State private var taskTitle = ""
    @State private var taskDeadline = Date()
    @State private var showDateSheet = false
    @State private var showAddStepPopup = false
    @State private var deadlineEnabled = true
    
    // Used in ConfirmDeletePopup and EditStepPopup.
    @State private var displayDeleteWindow = false
    @State private var displayEditWindow = false
    @State private var deletableStep: Step?
    @State private var editableStep: Step = Step()
    
    
    // Used in ConfirmAddTaskPopup
    @State private var showConfirmWindow = false
    @State private var taskDesc = ""
    @State private var currentLocation = ""
    @State private var addedSteps : [Step] = []
    
    @State private var location : TaskLocation?
    @State private var displayLocationWindow = false
  
    // Accessing the Context applied to the environment. Creating a child context to allow data updating in the Home screen.
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    var moc : NSManagedObjectContext
    // Used for dismissing the AddTaskView.
    @Environment(\.presentationMode) var presentationMode
    
    
    // Deletes the selected Step object from the addedSteps list.
    func deleteStep(at offsets: IndexSet) {
        addedSteps.remove(atOffsets: offsets)
    }
    init(moc: NSManagedObjectContext) {
        // Setting the Home screen context as the child context parent.
        self.moc = moc
        childContext.parent = moc
    }
    
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
                                    .foregroundColor(deadlineEnabled ? Color.black : Color.gray)
                                HStack {
                                  
                                    Text(taskDeadline, style: .date)
                                        .foregroundColor(deadlineEnabled ? Color.black : Color.gray)
                                    Text(taskDeadline, style: .time)
                                        .foregroundColor(deadlineEnabled ? Color.black : Color.gray)
                                
                                    Spacer()
                                 
                                    Toggle("", isOn: $deadlineEnabled)
                                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                                    Button(action: {withAnimation(.linear(duration: 0.3)) {
                                        showDateSheet.toggle()
                                    }}) {
                                        Image(systemName: "calendar")
                                            .font(.system(size: 40))
                                    }
                                    .disabled(!deadlineEnabled)
                                   
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
                                    Text(location?.name ?? "Location not set")
                                    Spacer()
                                    Button(action: {
                                        displayLocationWindow = true
                                    }) {
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
                                                StepView(step: step,
                                                    displayDeleteWindow: $displayDeleteWindow,
                                                         displayEditWindow: $displayEditWindow,
                                                         deletableStep: $deletableStep, editableStep: $editableStep)
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
            DatePickerPopup(display: $showDateSheet, taskDeadline: $taskDeadline)
            
            
            // Displays a popup which enables adding steps
            AddStepPopup(display: $showAddStepPopup, addStepToList: {step in
                addedSteps.append(step)
            }, moc: moc)
            
            
            // Displays a confirmation popup for Step deletion.
            ConfirmDeletePopup(display: $displayDeleteWindow, addedSteps: $addedSteps, step: $deletableStep, task: .constant(nil))
            
            
            // Displays a popup for editing a Step object.
            EditStepPopup(display: $displayEditWindow, editableStep: $editableStep)
            
            // Displays a View for adding a location.
            AddLocationView(moc: moc, display: $displayLocationWindow, location: $location)
            
            
            // Displays a confirmation popup
            ConfirmAddTaskPopup(display: $showConfirmWindow, taskTitle: $taskTitle, saveTaskToCoreData: {
                do {
                    // Creates a new Task object with the given State variables and saves it to Core Data.
                    let newTask = Task(context: moc)
                    newTask.date_added = Date()
                    newTask.name = self.taskTitle
                    newTask.desc = self.taskDesc
                    
                    if (deadlineEnabled) {
                        newTask.deadline = self.taskDeadline
                    }
                    
                    newTask.id = UUID()
                    newTask.taskLocation = location
                    
                    for step in addedSteps {
                        step.origin = newTask
                    }
                    try moc.save()
                    
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
    static var moc = NSManagedObjectContext()
    static var previews: some View {
        AddTaskView(moc: moc)
    }
}


