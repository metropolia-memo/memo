//
//  NoteView.swift
//  Memo
//
//  Created by Sirja Kosonen on 12.4.2022.
//

import SwiftUI
import CoreData

struct NoteView: View {
    let note: Note
    @State private var showingSheet = false
    
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
        VStack(alignment: .trailing) {
            
            // Edit note button
            Button(action: {showingSheet.toggle()}) {
                Image(systemName: "pencil")
                    .foregroundColor(Color.blue)
                    .font(.system(size: 40))
            }
            .padding(.horizontal, 15)
            .sheet(isPresented: $showingSheet) {
                ModifyNoteView(moc: moc, note: note)
            }
                
            
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
