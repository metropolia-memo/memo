//
//  History.swift
//  Memo
//
//  Created by Markus Nivasalo on 26.4.2022.
//

import SwiftUI

struct History: View {
    @StateObject private var dataController = DataController()

    @Environment(\.managedObjectContext) var moc
    
    var tasks: FetchedResults<Task>
    
    let dateFormatter = DateFormatter()
    
    init(tasks: FetchedResults<Task>) {
        self.tasks = tasks
        dateFormatter.dateFormat = "dd.MM.yy"
    }
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(getDates(tasks: tasks), id: \.self) { date in
                            let today = dateFormatter.string(from: Date())
                            Text(date == today ? "Today" : date)
                                .font(.title)
                                .fontWeight(.bold)
                            ForEach(tasks) { task in
                                let taskDeadline = dateFormatter.string(from: task.deadline!)
                                if (taskDeadline == date) {
                                    NavigationLink(destination: Tasks(moc: moc, updatedTask: task, task: task).environment(\.managedObjectContext, dataController.container.viewContext)) {
                                        HistoryTaskRow(task: task, today: (taskDeadline == today))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
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
        if (task.deadline! > Date()) {
            continue
        }
        dates.append(dateFormatter.string(from: task.deadline!))
    }

    dates = Array(Set(dates))
    dates.sort {
        dateFormatter.date(from: $0)! > dateFormatter.date(from: $1)!
    }
    return dates
}

//struct History_Previews: PreviewProvider {
//    static var previews: some View {
//        History()
//    }
//}
