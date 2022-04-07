//
//  MemoApp.swift
//  Memo
//
//  Created by Markus Nivasalo on 4.4.2022.
//

import SwiftUI

@main
struct MemoApp: App {
    
    // @StateObject: keeps the referenced object live for the entire time.
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            Home()
        }
    }
}
