//
//  ContentView.swift
//  Memo
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showMenu = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            Home(showMenu: self.$showMenu)
            if self.showMenu {
                GeometryReader { geometry in
                    DrawerMenuView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width/2)
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

