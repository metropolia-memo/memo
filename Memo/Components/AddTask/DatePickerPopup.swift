//
//  DatePickerPopup.swift
//  Memo
//
//  Created by iosdev on 8.4.2022.
//

import SwiftUI

struct DatePickerPopup: View {
    
    @Binding var display : Bool
    @Binding var taskDeadline : Date
    var displayToFalse : () -> Void
    
    var body: some View {
        ZStack {
            if display {
                Color.black.opacity(display ? 0.5 : 0).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 0) {
              
                    Text("Select a date")
                        .font(.title)
                
                    DatePicker("", selection: $taskDeadline, displayedComponents: [.date, .hourAndMinute])
                        .padding(.trailing, 5)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                    
                    
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
            .background(Color(red: 249, green: 249, blue: 249))
            .cornerRadius(30)
            .shadow(radius: 50)
            .padding()
        }
    }
}

struct DatePickerPopup_Previews:
    PreviewProvider {
  
  
    
    static var previews: some View {
        DatePickerPopup(display: .constant(true), taskDeadline: .constant(Date()), displayToFalse: {})
    }
    }
}
