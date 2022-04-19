//
//  AddNoteView.swift
//  Memo
//
//  Created by Sirja Kosonen on 15.4.2022.
//

import SwiftUI

struct AddNoteView: View {
    
    @State private var note = ""
    @State private var noteTitle = ""
    @State private var showAlert = false
    @State private var sensitive = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    // Input title card
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Title")
                                .bold()
                            HStack {
                                TextField("Note title", text: $noteTitle)
                                Button(action: {}) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(Color.blue)
                                        .font(.system(size: 40))
                                }
                            }
                        }
                        .padding(15)
                        .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(5)
                    
                    // Sensitive note switch
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Sensitive note")
                                    .bold()
                                Toggle("", isOn: $sensitive)
                            }
                        }
                        .padding(15)
                        .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal, 5)
                    
                    // Input note
                    TextField("Note", text: $note)
                        .padding(20)
                        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                        .multilineTextAlignment(.leading)
                        .cornerRadius(10)
                        .padding(5)
                    
                    // TODO: Save button
                }
            }
            .navigationTitle("")
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNoteView()
        }
    }
}
