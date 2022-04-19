//
//  TaskRow.swift
//  Memo
//
//  Created by iosdev on 17.4.2022.
//

import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: Task
    let tasks: FetchedResults<Task>
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "list.bullet.indent")
                .frame(width: 50, height: 100)
                .scaleEffect(3)
            Text("\(task.stepsArray.count) steps")
                .font(.body)
                .fontWeight(.bold)
            Spacer()
            Text("\(task.wrappedName)")
                .font(.body)
                .fontWeight(.bold)
        }
        .frame(width: 100)
        .padding()
        .background((task.id == tasks[tasks.count - 1].id ? Color.accentColor : Color.cyan))
        .foregroundColor(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

