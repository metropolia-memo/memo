//
//  CustomAnnotation.swift
//  Memo
//
//  Created by iosdev on 26.4.2022.
//

import SwiftUI

struct CustomAnnotation: View {
    var body: some View {
        
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.blue)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.blue)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct CustomAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CustomAnnotation()
    }
}
