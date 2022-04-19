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
    
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                Home()
                    .environment(\.managedObjectContext, dataController.container.viewContext)

            }
            
        }
        
        
    }
}
