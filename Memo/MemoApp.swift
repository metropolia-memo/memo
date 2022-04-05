//
//  MemoApp.swift
//  Memo
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI

@main
struct MemoApp: App {
    
    // @StateObject: keeps the referenced object live for the entire time.
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            
            // Adding the DataController into the SwiftUI environment.
            // viewContext: contains the newest modified data, as well enables loading and saving data to memory.
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
