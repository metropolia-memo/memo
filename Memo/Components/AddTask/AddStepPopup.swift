//
//  AddStepPopup.swift
//  Memo
//
//  Created by Oskari Arponen on 11.4.2022.
//

import SwiftUI

// A popup window used for adding steps.
// Utilized in AddTaskView.
struct AddStepPopup: View {
    
    @Binding var display : Bool
    @State var stepTitle : String = ""
    var addStepToList : (Step) -> Void
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            if display {
                Color.black.opacity(display ? 0.5 : 0).edgesIgnoringSafeArea(.all)
                VStack {
                    VStack(alignment: .leading) {
                        Text("Step title")
                            .font(.system(size: 20, weight: .medium))
                            .padding(.top)
                  
                        TextField("insert title", text: $stepTitle)
                       
                            .padding(.vertical, 20)
                            .font( .system(size: 30, weight: .medium))
                      
                    }
                    .padding()
               
                    
                    
                    HStack(spacing: 0) {
                        
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            display = false                       }}) {
                            Text("Cancel")
                                    .foregroundColor(Color.white)
                                    
                        }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                
                        // Creates a new Step object and adds it to the addSteps list in AddTaskView. After this, navigate back.
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            // TODO: Add step to list
                            
                            let newStep = Step(context: moc)
                            newStep.desc = stepTitle
                            newStep.id = UUID()
                            
                            addStepToList(newStep)
                            stepTitle = ""
                            display = false
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

    struct AddStepPopup_Previews: PreviewProvider {
        
        static var previews: some View {
            AddStepPopup(display: .constant(true), addStepToList: {Step in})
        }
    }
}
