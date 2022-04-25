//
//  StepView.swift
//  Memo
//
//  Created by Oskari Arponen on 14.4.2022.
//

import SwiftUI

// Displays a Step object, with a delete and edit button.
struct StepView: View {
    
    
    // Accessing the Context applied to the environment.
    @Environment(\.managedObjectContext) var moc
    
    // step: The currently displayed Step object.
    @StateObject var step : Step
    
    // offset manages the position of the StepView object in the x-axis. Used for creating a DragGesture.
    @State private var offset : Float = 0

    // Manages the displayed status of the Delete and Edit popups.
    @Binding var displayDeleteWindow : Bool
    @Binding var displayEditWindow : Bool
    
    
    // deletableStep and editableStep used for controlling what Step object the Delete and Edit popups handle.
    @Binding var deletableStep : Step?
    @Binding var editableStep : Step
    
    @Binding var editingTask : Bool
    
    
    var body: some View {
        ZStack {
            
            HStack {
                
                Button(action: {
                    editableStep = step
                    offset = 0
                    displayEditWindow = true
                }) {
                    Image(systemName: "pencil")
                        .font(.system(size: 30))
                        .foregroundColor(Color.blue)
                        .padding(5)
                        .shadow(radius: 3)
                }
                
                Button(action: {
                    deletableStep = step
                    offset = 0
                    displayDeleteWindow = true
                    
                }) {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color.red)
                        .padding(5)
                        .shadow(radius: 3)
                }
                    
            }
            .frame(
                   maxWidth: .infinity,
                   maxHeight: 35, alignment: .trailing)
            .offset(x: CGFloat(offset + 100))
            
            
            HStack {
                Image(systemName: step.completed ? "checkmark.circle.fill" : "checkmark.circle")
                    .foregroundColor(step.completed ? Color.blue : Color.gray)
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
                   maxHeight: 35, alignment: .leading)
        
            .padding(10)
           
            .background(Color(red: 242/255, green: 242/255, blue: 242/255))
            .cornerRadius(10)
            .shadow(radius: 5)
            .contentShape(Rectangle())
            .offset(x: CGFloat(offset))
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
        }
    }
    
    
    // Defines how much the Step can slide in the x-axis.
    func onChanged(value: DragGesture.Value) {
        
        if (value.translation.width <= -100) {
            offset = Float(-100)
        } else if (value.translation.width > 0) {
            offset = 0
        } else {
            offset = Float(value.translation.width)
        }
        
    }
    
    
    // Defines what happens after the swipe motion ends.
    func onEnd(value: DragGesture.Value) {
        
        if (value.translation.width > -40) {
            offset = 0
        } else {
            offset = Float(-100)
        }
        
    }
    
}

struct StepView_Previews: PreviewProvider {
    
    static var previews: some View {
        StepView(step: Step(), displayDeleteWindow: .constant(false), displayEditWindow: .constant(false), deletableStep: .constant(Step()), editableStep: .constant(Step()), editingTask: .constant(false))
    }
}
