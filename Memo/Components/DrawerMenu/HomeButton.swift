//
//  HomeButton.swift
//  Memo
//
//  Created by iosdev on 28.4.2022.
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
