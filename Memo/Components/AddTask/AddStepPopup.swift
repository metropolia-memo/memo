//
//  AddStepPopup.swift
//  Memo
//
//  Created by iosdev on 11.4.2022.
//

import SwiftUI

struct AddStepPopup: View {
    
    @Binding var display : Bool
    var addStep : () -> Void
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddStepPopup_Previews: PreviewProvider {
    static var previews: some View {
        AddStepPopup(display: .constant(false), addStep:{})
    }
}
