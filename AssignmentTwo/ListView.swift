//
//  ListView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct ListView: View {
    //Parent Checklist
    @Binding var list: ChecklistDataModel
    @State var checklistName: String = ""
    @State var displayName = ""

    //Sub-Item/s
    @Environment(\.editMode) var editMode
    var count: Int
    @State var itemMarked = false
    @State var newItem = ""
    @State var checklistItems: [[String]] = []
    @State var tempList: [[String]] = []

    var body: some View {
        if(editMode?.wrappedValue == .inactive) {
            EditView(item: $checklistName)
            HStack {
                TextField("Add Item:", text: $newItem)
                Button(action: {
                    tempList.append([newItem, "square"])
                    newItem = ""
                }) {
                    Text("+")
                }
            }
        }

            List {
                ForEach($tempList, id:\.self) { $item in
                    HStack {
                        Text(item[0])
                        Spacer()
                        Image(systemName: "\(item[1])")
                    }
                    .onTapGesture {
                        if(item[1] == "checkmark.square.fill") {
                            item[1] = "square"
                        }
                        else {
                            item[1] = "checkmark.square.fill"
                        }
                    }
                }
                .onDelete { indices in
                    tempList.remove(atOffsets: indices)
                }
                .onMove { indices, i in
                    tempList.move(fromOffsets: indices, toOffset: i)
                }
            }
        .navigationTitle("\(checklistName)")
        .navigationBarItems(
            leading:
                Button(action: {
                    if itemMarked {
                        tempList = checklistItems
                        itemMarked.toggle()
                    } else {
                        checklistItems = tempList
                        tempList = tempList.map{ [$0[0], "square"] }
                        itemMarked.toggle()
                    }
                }) {
                    if(editMode?.wrappedValue == .active) {
                        Text(itemMarked ? "Reset" : "Undo")
                    }
                },
            trailing:
                HStack {
                    Button(action: {
                        list.checklists[count].items = tempList
                        checklistItems = tempList
                        list.saveChecklists()
                    }) {
                        if(editMode?.wrappedValue == .active) {
                            Text("Save")
                        }
                    }
                    EditButton()
                }
        )
        .onAppear {
            checklistName = list.checklists[count].name
            checklistItems = list.checklists[count].items
            tempList = list.checklists[count].items
        }
        .onDisappear {
            list.checklists[count].name = checklistName
            list.checklists[count].items = checklistItems
        }
        .padding()
    }
}
