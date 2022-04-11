//
//  AddStepPopup.swift
//  Memo
//
//  Created by iosdev on 11.4.2022.
//

import SwiftUI

struct AddStepPopup: View {
    
    @Binding var display : Bool
    @Binding var taskTitle : String
    var displayToFalse : () -> Void
    
    
    var body: some View {
        ZStack {
            if display {
                Color.black.opacity(display ? 0.5 : 0).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    TextField("Change title", text: $taskTitle)
                    Text("Select a date")
                        .font(.title)
                    
                    
                    Button(action: {withAnimation(.linear(duration: 0.3)) {
                        displayToFalse()                       }}) {
                        Text("Confirm")
                                .foregroundColor(Color.white)
                    }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
          
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
            AddStepPopup(display: .constant(false), taskTitle: .constant("A title"), displayToFalse: {})
        }
    }
}
