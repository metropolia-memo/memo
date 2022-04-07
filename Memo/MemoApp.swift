//
//  MemoApp.swift
//  Memo
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI

@main
struct MemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Home()
            }
        }
    }
}
