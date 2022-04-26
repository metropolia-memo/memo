//
//  Tasks.swift
//  Memo
//
//  Created by iosdev on 21.4.2022.
//

import SwiftUI

struct Tasks: View {
    var task : Task
    var body: some View {
        ZStack() {
            MapView(task: task)
            SlideUp(task: task)
        }
    }
}

//struct Tasks_Previews: PreviewProvider {
//    static var previews: some View {
//        Tasks()
//    }
//}
