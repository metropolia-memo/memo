//
//  Home.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            VStack {
                HomeHeaderView()
                HomeFooterView()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
