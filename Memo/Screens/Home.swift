//
//  Home.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HomeHeaderView()
                    HomeFooterView()
                }
            }
            
            .navigationBarTitle("", displayMode: .inline)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {} ) {
                    Image(systemName: "line.horizontal.3")
                        .scaleEffect(2)
                        .foregroundColor(Color.black)
                }
                .accessibilityLabel("Drawer Menu")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
