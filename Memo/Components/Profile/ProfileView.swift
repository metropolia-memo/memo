//
//  ProfileView.swift
//  Memo
//
//  Created by Jani Salo on 12.4.2022.
//

import SwiftUI
import ImagePickerModule

struct ProfileView: View {
    
    @State private var isPickingImage = false
    
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        ScrollView {
            ProfilePicture()
                .frame(width: 200, height: 200)
                .onTapGesture { isPickingImage.toggle() }
            VStack {
                Text("Nickname")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                TextField("Nickname", text: $userSettings.nickname)
                    .onChange(of: userSettings.nickname) { input in
                        if input.count > 10 {
                            userSettings.nickname.popLast()
                        }
                    }
                    .font(.title)
                    .padding(.all, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                Divider()
                    .padding(.horizontal, 30)
            }
            
        }
        .sheet(isPresented: $isPickingImage) {
            ImagePicker(sourceType: .photoLibrary) { userSettings.image = $0 }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
