//
//  EditStepPopup.swift
//  Memo
//
//  Created by iosdev on 14.4.2022.
//

import SwiftUI

struct EditStepPopup: View {
    @Binding var display : Bool
    @Binding var editableStep : Step
    @State var newDesc : String = ""
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            if display {
                Color.black.opacity(display ? 0.5 : 0).edgesIgnoringSafeArea(.all)
                VStack {
                    VStack(alignment: .leading) {
                        Text("Edit step title")
                            .font(.system(size: 20, weight: .medium))
                            .padding(.top)
                  
                        TextField("Insert new title", text: $newDesc)
                       
                            .padding(.vertical, 20)
                            .font( .system(size: 30, weight: .medium))
                      
                    }
                    .padding()
               
                    
                    
                    HStack(spacing: 0) {
                        
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            display = false                     }}) {
                            Text("Cancel")
                                    .foregroundColor(Color.white)
                                    
                        }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                
                        // Edits the chosen Step object. After this, navigate back.
                        Button(action: {withAnimation(.linear(duration: 0.3)) {
                            editableStep.desc = newDesc
                            newDesc = ""
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

    struct EditStepPopup_Previews: PreviewProvider {
        static var previews: some View {
            EditStepPopup(display: .constant(true), editableStep: .constant(Step()))
        }
    }
}
