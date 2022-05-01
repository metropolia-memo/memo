//
//  ProfileView.swift
//  Memo
//
//  Created by Jani Salo on 12.4.2022.
//

import SwiftUI
import UIKit
import ImagePickerModule

struct ProfileView: View {
    
    private var screenWidth = UIScreen.main.bounds.width
    private var screenHeight = UIScreen.main.bounds.height
    
    @State private var isPickingImage = false
    
    @State private var showNotifications = true
    @State private var darkMode = false
    @State private var enableLocation = true
    @State private var setting4 = true
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ScrollView {
            ProfilePicture()
                .frame(width: 200, height: 200)
                .onTapGesture { isPickingImage.toggle() }
            Text("Account Created 11/02/22")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
                .frame(width: 200, height: 20)
                .padding()
            VStack {
                Toggle("Notifications", isOn: $showNotifications)
                        .font(.system(size: 21))
                        .frame(width: screenWidth - 40, height: 50)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 7)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                Toggle("Dark Mode", isOn: $darkMode)
                        .font(.system(size: 21))
                        .frame(width: screenWidth - 40, height: 50)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 7)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                Toggle("Enable location", isOn: $enableLocation)
                        .font(.system(size: 21))
                        .frame(width: screenWidth - 40, height: 50)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 7)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                Toggle("Setting 4", isOn: $setting4)
                    .font(.system(size: 21))
                    .frame(width: screenWidth - 40, height: 50)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 7)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
                .frame(width: screenWidth, height: 400)
                .background(Color.white)
                .cornerRadius(50)
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init(UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.2)))
            .sheet(isPresented: $isPickingImage) {
                ImagePicker(sourceType: .photoLibrary) { selectedImage in
                    userSettings.image = selectedImage
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
