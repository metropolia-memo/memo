//
//  UserSettings.swift
//  Memo
//
//  Created by Andras Adam on 1.5.2022.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @Published var image: UIImage? {
        didSet {
            if let data = image {
                let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
                if let encodedData = encodedData {
                    UserDefaults.standard.set(encodedData, forKey: "image")
                }
            }
        }
    }
    
    init() {
        let data = UserDefaults.standard.data(forKey: "image")
        if let data = data {
            let decodedData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            if let image = decodedData {
                self.image = image
            }
        }
    }
}
