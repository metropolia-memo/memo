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
            TextField("Nickname", text: $userSettings.nickname)
                .font(.title)
                .padding(.all, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            ProfileSettingToggle("Notifications", isOn: $userSettings.notifications)
            ProfileSettingToggle("Dark mode", isOn: $userSettings.darkmode)
            ProfileSettingToggle("Enable location", isOn: $userSettings.location)
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
