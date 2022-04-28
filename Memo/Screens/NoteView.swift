import SwiftUI
import CoreData
import LocalAuthentication

struct NoteView: View {
    @ObservedObject var note: Note
    @State private var isAuthenticated = false
    @State private var isConfirmingDelete = false
    
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    var moc: NSManagedObjectContext
    var authContext = LAContext()
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase
    
    init(moc: NSManagedObjectContext, note: Note) {
        self.moc = moc
        childContext.parent = moc
        self.note = note
    }
    
    func authenticate() {
        if (note.isSensitive && !isAuthenticated) {
            let reason = "This is a sensitive note, you must authenticate yourself before viewing it."
            authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success {
                    isAuthenticated = true
                } else {
                    print(error?.localizedDescription ?? "Authentication failed with unknown error")
                    isAuthenticated = false
                }
            }
        }
    }
    
    func save() {
        if (!note.isSensitive || isAuthenticated) {
            if (note.title == "") {
                note.title = "Unnamed"
            }
            do {
                try moc.save()
                print("Note '\(note.title)' saved succesfully")
            } catch {
                print("Saving note failed with exception \(error.localizedDescription)")
            }
        }
    }
    
    func delete() {
        if (!note.isSensitive || isAuthenticated) {
            // TODO: delete note
        }
    }
    
    func toggleSensitivity() {
        if (!note.isSensitive || isAuthenticated) {
            // If the user can modify the sensitivity they are either authenticated already or have seen the note anyway
            isAuthenticated = true
            note.isSensitive.toggle()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if (note.isSensitive && !isAuthenticated) {
                VStack(alignment: .center, spacing: 24) {
                    Text("This is a sensitive note, you must authenticate yourself before viewing it.")
                        .multilineTextAlignment(.center)
                    Button("Authenticate", action: authenticate)
                }
            } else {
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Title", text: $note.title)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $note.note_text)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .toolbar() {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    save()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Back")
                    }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button(action: { toggleSensitivity() }) {
                        note.isSensitive
                         ? Label("Make unsecure", systemImage: "lock.open.fill")
                         : Label("Make secure", systemImage: "lock.fill")
                    }
                        .disabled(note.isSensitive && !isAuthenticated)
                    Button(role: .destructive, action: { isConfirmingDelete = true }) {
                        Label("Delete", systemImage: "trash.fill")
                    }
                        .disabled(note.isSensitive && !isAuthenticated)
                    Button(role: .cancel, action: {}) {
                        Label("Cancel", image: "xmark")
                    }
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
                .confirmationDialog("Are you sure you want to delete this note?", isPresented: $isConfirmingDelete) {
                    Button("Delete", role: .destructive) { delete() }
                    Button("Cancel", role: .cancel) { isConfirmingDelete = false }
                } message: {
                    Text("Are you sure you want to delete this note?")
                }
            }
        }
        .onAppear() { authenticate() }
        .onDisappear() { isAuthenticated = false }
        .onChange(of: scenePhase) { _ in save() }
    }
}
