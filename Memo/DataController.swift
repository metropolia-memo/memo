//
//  DataController.swift
//  Memo
//
//  Created by Oskari Arponen on 4.4.2022.
//

import CoreData
import Foundation

// ObservableObject protocol: enables the usage of @StateObject
class DataController: ObservableObject {
    
    // Creating a PersistentContainer utilizing the Memo.xcdatamodelId file
    // NSPersistentContainer: Contains the data loaded and saved in the device.
    let container = NSPersistentContainer(name: "Memo")
    
    
    init() {
        
        // Loading PersistentStores when the DataController is created
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load CoreData: \(error.localizedDescription)")
            }
        }
        
    }
}
