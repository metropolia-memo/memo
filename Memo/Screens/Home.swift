//
//  Home.swift
//  Memo
//
//  Created by iosdev on 7.4.2022.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                HomeHeaderView()
            }
            .padding(10)
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
