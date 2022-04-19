//
//  NoteView.swift
//  Memo
//
//  Created by Sirja Kosonen on 12.4.2022.
//

import SwiftUI

struct NoteView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            
            // Edit note button
            Button(action: {}) {
                Image(systemName: "pencil")
                    .foregroundColor(Color.blue)
                    .font(.system(size: 40))
            }
                .padding(.horizontal, 15)
            
            // Note
            ScrollView {
            Text("A lot of text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ornare dolor a erat ultrices euismod. Etiam sed sapien euismod elit pulvinar volutpat. Duis a erat ut mauris dictum rhoncus sit amet a risus. Nullam sollicitudin mauris magna, vitae auctor justo ullamcorper ut. In magna ex, varius nec massa at, semper aliquam sapien. Integer posuere risus lectus, et tempor ante molestie sit amet. ")
                .padding(20)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .multilineTextAlignment(.leading)
                .cornerRadius(10)
                .padding(10)
            }
        }
        .navigationTitle("iOS Lecture")
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoteView()
        }
    }
}
