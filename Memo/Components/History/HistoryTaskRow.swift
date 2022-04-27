//
//  HistoryTaskRow.swift
//  Memo
//
//  Created by iosdev on 26.4.2022.
//

import SwiftUI

struct HistoryTaskRow: View {
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
        Spacer()
    }
}

struct HistoryTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTaskRow()
    }
}
