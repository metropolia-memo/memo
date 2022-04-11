//
//  HomeHeaderView.swift
//  Memo
//
//  Created by iosdev on 7.4.2022.
//

import SwiftUI

struct HomeHeaderView: View {
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
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {} ) {
                    Image(systemName: "line.horizontal.3")
                        .scaleEffect(1.5)
                        .foregroundColor(Color.black)
                }
                .accessibilityLabel("Drawer Menu")
            }
        }
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
            .previewLayout(.sizeThatFits)
    }
}
