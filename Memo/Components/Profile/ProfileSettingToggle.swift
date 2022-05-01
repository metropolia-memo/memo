//
//  ProfileToggle.swift
//  Memo
//
//  Created by Andras Adam on 1.5.2022.
//

import Foundation
import SwiftUI

struct ProfileSettingToggle: View {
    
    var title: String
    var isOn: Binding<Bool>
    
    init(_ title: String, isOn: Binding<Bool>) {
        self.title = title
        self.isOn = isOn
    }
    
    var body: some View {
        HStack {
            Toggle(title, isOn: isOn)
                .font(.system(size: 20))
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
                .background(Color.white)
                .cornerRadius(10)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .cornerRadius(10)
        .shadow(radius: 8)
    }
}
