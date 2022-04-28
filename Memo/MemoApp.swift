//
//  MemoApp.swift
//  Memo
//
//  Created by Markus Nivasalo on 4.4.2022.
//

import SwiftUI

@main
struct MemoApp: App {
    
    @StateObject private var dataController = DataController()
    @StateObject private var drawerMenuState = DrawerMenuState()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(drawerMenuState)
            }
        }
    }
}
