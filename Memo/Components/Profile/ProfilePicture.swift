//
//  ProfilePicture.swift
//  Memo
//
//  Created by Andras Adam on 1.5.2022.
//

import Foundation
import SwiftUI

struct ProfilePicture: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        if let image = userSettings.image {
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: 200, maxHeight: 200)
                .scaledToFit()
                .foregroundColor(Color.blue)
                .cornerRadius(100)
                .padding(.all, 20)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(maxWidth: 200, maxHeight: 200)
                .scaledToFit()
                .foregroundColor(Color.blue)
                .cornerRadius(100)
                .padding(.all, 20)
        }
    }
}
