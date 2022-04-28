//
//  Home.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//

import SwiftUI

struct Home: View {
    
    @FetchRequest var tasks: FetchedResults<Task>
    @FetchRequest var notes: FetchedResults<Note>
    
    init() {
        self._tasks = FetchRequest(entity: Task.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.date_added, ascending: false)
        ])
        self._notes = FetchRequest(entity: Note.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.date_added, ascending: false)
        ])
    }
    
    var body: some View {
        ZStack {
            VStack {
                HomeHeaderView()
                HomeFooterView(tasks: tasks, notes: notes)
            }
            DrawerMenuContainer(tasks: tasks)
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                DrawerMenuToggleButton()
            }
        }
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
