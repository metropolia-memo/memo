//
//  Home.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//

import SwiftUI

struct Home: View {
    @State private var showMenu = false
    var body: some View {
        ZStack {
            DrawerMenuView(showMenu: $showMenu)
            VStack {
                VStack {
                    HomeHeaderView()
                    HomeFooterView()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    print("ÄHÄKUTTI")
                    showMenu.toggle()
                    print($showMenu)
                    
                } ) {
                    Image(systemName: "line.horizontal.3")
                        .scaleEffect(1.5)
                        .foregroundColor(Color.black)
                }
                .accessibilityLabel("Drawer Menu")
            }
        }
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
