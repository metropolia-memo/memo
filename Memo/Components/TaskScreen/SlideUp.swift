//
//  SlideUp.swift
//  Memo
//
//  Created by iosdev on 22.4.2022.
//

import SwiftUI
import CoreData


//User can drag this sliding menu up to see task name, address and steps of the task
struct SlideUp: View {
    
    //Offsets for slider bar
    @State private var offsets = (top: CGFloat.zero, middle: CGFloat.zero, bottom: CGFloat.zero)
    @State private var offset: CGFloat = .zero
    @State private var lastOffset: CGFloat = .zero
    @State var show = false
    
    @ObservedObject var task: Task
    @State var steps: [Step]
    var moc : NSManagedObjectContext
    
    init(task: Task, moc: NSManagedObjectContext) {
        self.moc = moc
        self.task = task
        steps = task.stepsArray ?? []
    }
    
    var body: some View {        
        
        GeometryReader { geometry in
            VStack (spacing: 30) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 150, height: 2)
            
                HStack() {
                    Text(task.name ?? "Unknown")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 22, weight: .heavy))
                    Button {
                        print("button pressed")
                    } label: {
                        Image(systemName: "car.fill")
                    } .contentShape(Rectangle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(width: 40, height: 40)
                }
                if (task.deadline != nil) {
                    Text("Deadline \(task.deadline ?? Date(), style: .date)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                     
                } else {
                    Text("No deadline")
                        .frame(maxWidth: .infinity, alignment: .leading)
                
                }
                
                HStack() {
                    Image(systemName: "pin.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color(.systemBlue))
                    let location = task.taskLocation?.name ?? "No location given."
                    Text(location)
                        .font(.system(size: 18, weight: .heavy))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(task.desc ?? "Description not found")
                    .font(.system(size: 16, weight: .heavy))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    VStack() {
                        ForEach(steps) {step in
                            HStack(){
                            Button {
                                do {
                                    step.completed.toggle()
                                    try moc.save()
                                } catch {
                                    print("Failed to save step to Core Data. \(error)")
                                }
       
                            } label: {
                                if (step.completed == true) {
                                    Image(systemName: "chevron.down.circle.fill")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color(.systemBlue))
                                } else {
                                    Image(systemName: "chevron.down.circle")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color(.systemBlue))
                                }
                            }
                            Text(step.desc!)
                                .font(.system(size: 20))
                                
                                
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 8)
                            
                            if(step != steps[steps.count-1])  {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 7)
                                .padding(.bottom, 2)
                            }
                        }
                    } .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                
                Spacer()
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: min(self.offset, 20)))
            .animation(.interactiveSpring(), value: show)
            .onAppear {
                self.offsets = (
                    top: geometry.size.height / 3,
                    middle: geometry.size.height / 2,
                    bottom: geometry.size.height * 3 / 3.2
                )
                self.offset = self.offsets.bottom
                self.lastOffset = self.offset
            }
            .offset(y: self.offset)
            .gesture(DragGesture(minimumDistance: 5)
                        .onChanged { v in
                let newOffset = self.lastOffset + v.translation.height
                if ( newOffset > self.offsets.top && newOffset < self.offsets.bottom ) {
                    self.offset = newOffset
                }
            }
                        .onEnded { v in
                if (self.lastOffset == self.offsets.top && v.translation.height > 0) {
                    if (v.translation.height < geometry.size.height / 2) {
                        self.offset = self.offsets.middle
                    } else {
                        self.offset = self.offsets.bottom
                    }
                } else if (self.lastOffset == self.offsets.middle) {
                    if ( v.translation.height < 0) {
                        self.offset = self.offsets.top
                    } else {
                        self.offset = self.offsets.bottom
                    }
                } else if (self.lastOffset == self.offsets.bottom && v.translation.height < 0) {
                    if (abs(v.translation.height) > geometry.size.height / 2) {
                        self.offset = self.offsets.top
                    } else {
                        self.offset = self.offsets.middle
                    }
                }
                self.lastOffset = self.offset
            })
        }
        .edgesIgnoringSafeArea(.all)
    }
}




