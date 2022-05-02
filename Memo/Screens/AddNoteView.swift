//
//  AddNoteView.swift
//  Memo
//
//  Created by Sirja Kosonen on 15.4.2022.
//
//  Screen for creating a note
//

import SwiftUI
import CoreData

struct AddNoteView: View {
    
    // Used for showing an alert if title is missing and toggling sensitive mode.
    @State private var note = ""
    @State private var noteTitle = ""
    @State private var showAlert = false
    @State private var sensitive = false
    
    // Used for dismissing the AddNoteView.
    @Environment(\.presentationMode) var presentationMode
    
    // Accessing the Context applied to the environment. Creating a child context to allow data updating in the Home screen.
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    var moc : NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        // Setting the Home screen context as the child context parent.
        self.moc = moc
        childContext.parent = moc
    }
    
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
                                        .foregroundColor(Color(red: 45/255, green: 91/255, blue: 255/255))
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
                    
                    // Save button
                    // Shows the alert of missing title if field is empty
                    // Otherwise a new note is created
                    Button("Save", action: {
                        if noteTitle == "" {
                            return showAlert = true
                        } else {
                            do {
                                let newNote = Note(context: moc)
                                newNote.id = UUID()
                                newNote.date_added = Date()
                                newNote.title = self.noteTitle
                                newNote.isSensitive = self.sensitive
                                newNote.note_text = self.note
                                try moc.save()
                                
                                print("Note \( newNote) saved succesfully to Core Data.")
                            } catch {
                                print("Saving to Core Data failed. \(error)")
                            }
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    })
                        .frame(maxHeight: 50)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color(red: 45/255, green: 91/255, blue: 255/255))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("")
        }
        .alert("Title missing", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                showAlert = false
            }
        }
    }
}
