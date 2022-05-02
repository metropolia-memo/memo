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
    
    var tasks: FetchedResults<Task>
    
    @EnvironmentObject var drawerMenuState: DrawerMenuState
    @StateObject private var dataController = DataController()
    
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                // Profile area
                VStack(alignment: .leading) {
                    NavigationLink(destination: Profile().environment(\.managedObjectContext, dataController.container.viewContext)) {
                            ProfilePicture()
                                .frame(width: 60, height: 60)
                                .scaleEffect(3)
                    }
                    .padding(.top, 60)
                    .padding([.horizontal, .leading], 10)
                    
                    Text(userSettings.nickname)
                        .fontWeight(.bold)
                        .padding(.top, 25)
                        .padding([.horizontal, .leading], 10)
                        .foregroundColor(Color.white)
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
                    NavigationLink(destination: History(tasks: tasks)
                                    .environment(\.managedObjectContext, dataController.container.viewContext)
                                    .onAppear {
                        drawerMenuState.isOpen.toggle()
                        
                    }) {
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

//struct DrawerMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawerMenuView()
//    }
//}
