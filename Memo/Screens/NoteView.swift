//
//  NoteView.swift
//  Memo
//
//  Created by Sirja Kosonen on 12.4.2022.
//

import SwiftUI

struct NoteView: View {
    let note: Note
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
                Text(note.note_text)
                .padding(20)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .multilineTextAlignment(.leading)
                .cornerRadius(10)
                .padding(10)
            }
        }
        .navigationTitle(note.title)
    }
}

//struct NoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            NoteView()
//        }
//    }
//}
