//
//  SlideUp.swift
//  Memo
//
//  Created by iosdev on 22.4.2022.
//

import SwiftUI




struct SlideUp: View {
    @State private var offsets = (top: CGFloat.zero, middle: CGFloat.zero, bottom: CGFloat.zero)
    @State private var offset: CGFloat = .zero
    @State private var lastOffset: CGFloat = .zero
    @State var show = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 30) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 150, height: 2)
                
                Text("Task name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 22, weight: .heavy))
                    
                HStack() {
                    Image(systemName: "pin")
                        .font(.system(size: 18))
                        .foregroundColor(Color(.systemBlue))
                    Text("Address of the task")
                        .font(.system(size: 18))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Task description -> Task description -> task description")
                    .font(.system(size: 18))
                
                HStack() {
                    Image(systemName: "chevron.down.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color(.systemBlue))
                    Text("This is the task!")
                        .font(.system(size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack() {
                    Image(systemName: "chevron.down.circle")
                        .font(.system(size: 25))
                        .foregroundColor(Color(.systemBlue))
                    Text("This is the second task!")
                        .font(.system(size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: min(self.offset, 20)))
            .animation(.interactiveSpring(), value: show)
            .onAppear {
                self.offsets = (
                    top: geometry.size.height / 1.8,
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

/*struct SlideUp_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}*/


