//
//  HistoryTaskRow.swift
//  Memo
//
//  Created by Markus Nivasalo on 26.4.2022.
//

import SwiftUI

struct HistoryTaskRow: View {
    @ObservedObject var task: Task
    var today: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(task.wrappedName)")
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Spacer()
                Text(today ? "Deadline was today." : "Deadline was on \(task.deadline!, style: .date).")
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
