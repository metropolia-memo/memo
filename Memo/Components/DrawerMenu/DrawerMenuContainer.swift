//
//  DrawerMenuContainer.swift
//  Memo
//
//  Created by Andras Adam on 28.4.2022.
//

import Foundation
import SwiftUI

struct DrawerMenuContainer: View {
    
    @EnvironmentObject private var drawerMenuState: DrawerMenuState
    
    var body: some View {
        if drawerMenuState.isOpen {
            ZStack {
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                    .opacity(0.4)
                    .onTapGesture { drawerMenuState.isOpen.toggle() }
                HStack {
                    GeometryReader { geometry in
                        DrawerMenuView()
                            .frame(width: geometry.size.width * (2 / 3))
                    }
                    Spacer()
                }
            }
        }
    }
}
