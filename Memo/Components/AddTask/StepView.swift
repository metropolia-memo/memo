//
//  StepView.swift
//  Memo
//
//  Created by iosdev on 14.4.2022.
//

import SwiftUI

struct StepView: View {
    
    @Environment(\.managedObjectContext) var moc

    var step : Step
    @State private var offset : Float = 0
    @Binding var displayDeleteWindow : Bool
    @Binding var displayEditWindow : Bool
    @Binding var deletableStep : Step?
    @Binding var editableStep : Step
    
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
                }
                    
            }
            .frame(
                   maxWidth: .infinity,
                   maxHeight: 35, alignment: .trailing)
            .offset(x: CGFloat(offset + 100))
            
            
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
        StepView(step: Step(), displayDeleteWindow: .constant(false), displayEditWindow: .constant(false), deletableStep: .constant(Step()), editableStep: .constant(Step()))
    }
}
