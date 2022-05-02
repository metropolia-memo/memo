//
//  UpcomingTaskRow.swift
//  Memo
//
//  Created by Markus Nivasalo on 19.4.2022.
//
//  Singular task item shown in the Home screen's task portion, in the upcoming tasks. Displays if the deadline is within 48
//  hours
//
import SwiftUI

struct UpcomingTaskRow: View {
    @ObservedObject var task: Task
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(task.wrappedName)")
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Spacer()
                if (task.deadline != nil) {
                    Text("Deadline \(task.deadline!, style: .date)")
                        .font(.caption)
                } else {
                    Text("No deadline")
                        .font(.caption)
                }
                
            }
        }
        .padding()
        .background(Color.accentColor)
        .foregroundColor(Color.white)
        .cornerRadius(20)
        Spacer()
    }
}

