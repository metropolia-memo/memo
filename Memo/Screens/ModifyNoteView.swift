//
//  ModifyNoteView.swift
//  Memo
//
//  Created by Markus Nivasalo on 25.4.2022.
//

import SwiftUI
import CoreData

struct ModifyNoteView: View {
    @ObservedObject var note: Note
    
    @State private var showAlert = false
    
    // Used for dismissing the AddNoteView.
    @Environment(\.presentationMode) var presentationMode
    
    // Accessing the Context applied to the environment. Creating a child context to allow data updating in the Home screen.
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    var moc : NSManagedObjectContext
    
    init(moc: NSManagedObjectContext, note: Note) {
        // Setting the Home screen context as the child context parent.
        self.moc = moc
        childContext.parent = moc
        self.note = note
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
                                TextField("Note title", text: $note.title)
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
                                Toggle("", isOn: $note.isSensitive)
                            }
                        }
                        .padding(15)
                        .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal, 5)
                    
                    // Input note
                    TextField("Note", text: $note.note_text)
                        .padding(20)
                        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                        .multilineTextAlignment(.leading)
                        .cornerRadius(10)
                        .padding(5)
                    
                    // Save button
                    // TODO: Sending/saving the information when clicked.
                    Button("Save", action: {
                        if note.title == "" {
                            return showAlert = true
                        } else {
                            do {
                                try moc.save()
                                print("Note \( note) saved succesfully to Core Data.")
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
    }
}

//struct ModifyNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifyNoteView()
//    }
//}
