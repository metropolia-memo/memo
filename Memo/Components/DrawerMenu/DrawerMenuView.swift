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
    @StateObject private var dataController = DataController()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                // Profile area
                VStack(alignment: .leading) {
                    NavigationLink(destination: Profile().environment(\.managedObjectContext, dataController.container.viewContext)) {
                            Image(systemName: "person.circle.fill")
                            // TODO: Delete foregroundColor when image changed to profile photo
                                .foregroundColor(Color.white)
                                .frame(width: 50, height: 50)
                                .scaleEffect(3)
                    }
                    .padding(.top, 60)
                    
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
                
                // Profile button
                HStack {
                    NavigationLink(destination: Profile()
                                    .environment(\.managedObjectContext, dataController.container.viewContext)
                                    .onAppear {
                        drawerMenuState.isOpen.toggle()
                        
                    }) {
                            ProfileButton()
                    }
                }
                .padding(10)
                
                // History button
                HStack {
                    Button(action: { drawerMenuState.isOpen.toggle() }) {
                        HistoryButton()
                    }
                }
                .padding(10)
                Divider()
                    .background(Color.black)
                    .padding(.top, 7)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 242/255, green: 242/255, blue: 242/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DrawerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerMenuView()
    }
}
