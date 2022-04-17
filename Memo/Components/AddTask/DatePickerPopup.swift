//
//  DatePickerPopup.swift
//  Memo
//
//  Created by Oskari Arponen on 8.4.2022.
//

import SwiftUI

// Displays a DatePicker, which is used to set a deadline for the Task object.
struct DatePickerPopup: View {
    
    // Handles the displayed status.
    @Binding var display : Bool
    
    // The current set deadline.
    @Binding var taskDeadline : Date
    
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
                        display = false                       }}) {
                        Text("Done")
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
        DatePickerPopup(display: .constant(true), taskDeadline: .constant(Date()))
    }
    }
}
