//
//  ContentView.swift
//  Memo
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Home()
            DrawerMenuContainer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

