//
//  DrawerMenuToggleButton.swift
//  Memo
//
//  Created by Andras Adam on 28.4.2022.
//

import Foundation
import SwiftUI

struct DrawerMenuToggleButton: View {
    @EnvironmentObject private var drawerMenuState: DrawerMenuState
    
    var body: some View {
        Button(action: { drawerMenuState.isOpen.toggle() }) {
            Image(systemName: "line.horizontal.3")
                .scaleEffect(1.5)
                .foregroundColor(Color.black)
        }
        .accessibilityLabel("Toggle drawer menu")
    }
}
