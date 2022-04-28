//
//  UpcomingTaskRow.swift
//  Memo
//
//  Created by Markus Nivasalo on 19.4.2022.
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
                Text("Deadline \(task.deadline!, style: .date)")
                    .font(.caption)
            }
        }
        .padding()
        .background(Color.accentColor)
        .foregroundColor(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.gray, radius: 7)
        Spacer()
    }
}

