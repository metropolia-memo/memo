//
//  Profile.swift
//  Memo
//
//  Created by iosdev on 12.4.2022.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView {
            VStack {
               
                    ProfileView()
                Spacer()
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
        
    }
}
