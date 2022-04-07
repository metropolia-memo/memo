//
//  HomeHeaderView.swift
//  Memo
//
//  Created by iosdev on 7.4.2022.
//

import SwiftUI

struct HomeHeaderView: View {
    @State private var searchInput: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome back, John")
                        .font(.system(size: 28))
                    Text("Last visit: 15/03/2022")
                        .font(.caption)
                }
                Button(action: {} ) {
                    Image(systemName: "person.circle.fill")
                        .frame(width: 100, height: 100)
                        .scaleEffect(5)
                }
            }
            .fixedSize()
            HStack {
                TextField("Search tasks...", text: $searchInput)
                    .textFieldStyle(.roundedBorder)
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.accentColor)
            }
        }
        .padding()
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
            .previewLayout(.sizeThatFits)
    }
}
