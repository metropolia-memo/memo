//
//  ProfileButton.swift
//  Memo
//
//  Created by iosdev on 28.4.2022.
//

import SwiftUI

struct ProfileButton: View {
    var body: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFill()
            .foregroundColor(Color.black)
            .frame(width: 25, height: 25)
        Text("Profile")
            .font(.headline)
            .foregroundColor(Color.black)
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton()
    }
}
