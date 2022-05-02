//
//  HomeButton.swift
//  Memo
//
//  Created by Sirja Kosonen on 28.4.2022.
//
//  Home button in the drawer menu (currently not in use)
//

import SwiftUI

struct HomeButton: View {
    var body: some View {
        Image(systemName: "house.fill")
            .resizable()
            .scaledToFill()
            .foregroundColor(Color.black)
            .frame(width: 25, height: 25)
        Text("Home")
            .font(.headline)
            .foregroundColor(Color.black)
    }
}

struct HomeButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeButton()
    }
}
