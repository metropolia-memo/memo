//
//  HistoryButton.swift
//  Memo
//
//  Created by Sirja Kosonen on 28.4.2022.
//
//  History button in the drawer menu
//

import SwiftUI

struct HistoryButton: View {
    var body: some View {
        Image(systemName: "clock")
            .resizable()
            .scaledToFill()
            .foregroundColor(Color.black)
            .frame(width: 25, height: 25)
        Text("History")
            .font(.headline)
            .foregroundColor(Color.black)
    }
}

struct HistoryButton_Previews: PreviewProvider {
    static var previews: some View {
        HistoryButton()
    }
}
