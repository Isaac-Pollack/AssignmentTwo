//
//  EditView.swift
//  AssignmentTwo
//
//  Created by Isaac Pollack on 14/4/2023.
//

import SwiftUI

struct EditView: View {
    @Binding var item: String
    @State var displayItem: String = ""
    @Environment(\.editMode) var editMode

    var body: some View {
        VStack {
            if(editMode?.wrappedValue == .active) {
                HStack {
                    Image(systemName: "square.and.pencil")
                    TextField("Input:", text: $displayItem)
                    Button("Cancel") {
                        displayItem = item
                    }
                    .onAppear {
                        //Set initial value to below preview/binded 'name'
                        displayItem = item
                    }
                    .onDisappear {
                        //When we leave the view; set the name to the changed value
                        item = displayItem
                    }
                }
            }
        }
    }
}
