//
//  History.swift
//  Memo
//
//  Created by Markus Nivasalo on 26.4.2022.
//

import SwiftUI

struct History: View {
    @State var searchInput: String = ""
    @StateObject private var dataController = DataController()

    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest var tasks: FetchedResults<Task>
    
    let dateFormatter = DateFormatter()
    
    init() {
        self._tasks = FetchRequest(entity: Task.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.date_added, ascending: false)
        ])
        dateFormatter.dateFormat = "dd.MM.yy"
    }
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                HStack {
                    TextField("Search tasks...", text: $searchInput)
                        .textFieldStyle(.roundedBorder)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.accentColor)
                }
                .padding()
                VStack (alignment: .leading) {
                    ScrollView {
                        LazyVStack {
                            ForEach(getDates(tasks: tasks), id: \.self) { date in
                                Text(date)
                                ForEach(tasks) { task in
                                    let taskDeadline = dateFormatter.string(from: task.deadline!)
                                    if (taskDeadline == date) {
                                        UpcomingTaskRow(task: task)
                                    }
                                }
                            }
                        }
                    }
                }
            }
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
        .navigationBarTitle("", displayMode: .inline)
        
    }
}

func getDates(tasks: FetchedResults<Task>) -> [String] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yy"
    var dates : [String] = []
    for task in tasks {
        if (task.deadline == nil) {
            continue
        }
        dates.append(dateFormatter.string(from: task.deadline!))
    }
    dates = Array(Set(dates))
    return dates
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
