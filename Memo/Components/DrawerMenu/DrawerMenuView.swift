//
//  DrawerMenuView.swift
//  Memo
//
//  Created by Sirja Kosonen on 20.4.2022.
//

import Foundation
import SwiftUI

// TODO: Slide-out animation
struct DrawerMenuView: View {
    
    @EnvironmentObject var drawerMenuState: DrawerMenuState
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                // Profile area
                VStack(alignment: .leading) {
                    Button(action: { drawerMenuState.isOpen.toggle() }) {
                        Image(systemName: "person.circle.fill")
                        // TODO: Delete foregroundColor when image changed to profile photo
                            .foregroundColor(Color.black)
                            .frame(width: 50, height: 50)
                            .scaleEffect(3)
                    }
                    
                    Text("John Doe")
                        .padding(.top, 25)
                        .foregroundColor(Color.white)
                    Text("john.doe@gmail.com")
                        .font(.subheadline)
                        .accentColor(Color.white)
                }
                .padding(.top, 30)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 124/255, green: 153/255, blue: 255/255))
                
                // Home button
                // DO NOT NAVIGATE, just close the modal, or core data crashes
                HStack {
                    Button(action: { drawerMenuState.isOpen.toggle() }) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(Color.black)
                            .frame(width: 25, height: 25)
                        Text("Home")
                            .font(.headline)
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.top, 30)
                .padding(10)
                
                // Profile button
                // TODO: add navigation
                HStack {
                    Button(action: { drawerMenuState.isOpen.toggle() }) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(Color.black)
                            .frame(width: 25, height: 25)
                        Text("Profile")
                            .font(.headline)
                            .foregroundColor(Color.black)
                    }
                }
                .padding(10)
                
                // History button
                // TODO: add navigation
                HStack {
                    Button(action: { drawerMenuState.isOpen.toggle() }) {
                        Image(systemName: "clock")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(Color.black)
                            .frame(width: 25, height: 25)
                        Text("History")
                            .font(.headline)
                            .foregroundColor(Color.black)
                        
                    }
                }
                .padding(10)
                Divider()
                    .background(Color.black)
                    .padding(.top, 30)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 242/255, green: 242/255, blue: 242/255))
            .edgesIgnoringSafeArea(.all)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                DrawerMenuToggleButton()
            }
        }
    }
}

struct DrawerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerMenuView()
    }
}
