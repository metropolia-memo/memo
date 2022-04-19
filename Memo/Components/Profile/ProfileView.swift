//
//  ProfileView.swift
//  Memo
//
//  Created by Jani Salo on 12.4.2022.
//

import SwiftUI
import UIKit



struct ProfileView: View {
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    let bgColor = Color("#E5E5E5")
    
    @State private var showNotifications = true
    @State private var darkMode = false
    @State private var enableLocation = true
    @State private var setting4 = true
    
    var body: some View {
        HStack () {
            VStack(){
                Text("Name")
                    .font(.system(size: 20))
                    .bold()
                Button(action: {} ) {
                    Image(systemName: "person.circle.fill")
                        .frame(width: 200, height: 200)
                        .scaleEffect(9)
                    
            }
                Text("Account Created 11/02/22")
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    .frame(width: 200, height: 20)
                    .padding()
                
                
                Button(action: {
                    
                }) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 60)
                        .background(Color.blue)
                        .font(.system(size: 22))
                        .cornerRadius(35)
                        .padding(10)
                        .shadow(radius: 25)
                }
                
                Spacer()
                
                VStack() {
                    Spacer()
                    
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
                    
                    Spacer()
                    
                }.frame(width: screenWidth, height: 400)
                .background(Color.white)
                .cornerRadius(50)
                    
                
                
                
                
            }
        }.frame(
            minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init(UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.2)))
        
        
            
            
        }
    

    }
    

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
