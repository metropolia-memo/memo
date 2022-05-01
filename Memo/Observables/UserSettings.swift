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
    
    @Published var nickname: String {
        didSet {
            UserDefaults.standard.set(nickname, forKey: "nickname")
        }
    }
    
    @Published var notifications: Bool {
        didSet {
            UserDefaults.standard.set(notifications, forKey: "notifications")
        }
    }
    
    @Published var darkmode: Bool {
        didSet {
            UserDefaults.standard.set(darkmode, forKey: "darkmode")
        }
    }
    
    @Published var location: Bool {
        didSet {
            UserDefaults.standard.set(location, forKey: "location")
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
        self.nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        self.notifications = UserDefaults.standard.bool(forKey: "notifications")
        self.darkmode = UserDefaults.standard.bool(forKey: "darkmode")
        self.location = UserDefaults.standard.bool(forKey: "location")
    }
    
}
