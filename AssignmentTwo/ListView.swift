//
//  ListView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct TickBoxStyle: ToggleStyle {
    //Extend on ToggleStyle : makeBody for styling
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct ListView: View {
    //Parent Checklist
    @Binding var list: ChecklistDataModel
    @State var checklistName: String = ""
    @State var displayName = ""

    //Sub-Item/s
    var count: Int
    @State var itemMarked = false
    @State var newItem = ""
    @State var checklistItems: [[String]] = []
    @State var tempList: [[String]] = []

    var body: some View {
        VStack {
            EditView(item: $checklistName)
            HStack {
                TextField("Add Item:", text: $newItem)
                Button(action: {
                    tempList.append([newItem])
                    newItem = ""
                }) {
                    Text("+")
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
                        if(item[1] == "checkmark") {
                            item[1] = "xmark"
                        } else {
                            item[1] = ""
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
                        tempList = tempList.map{ [$0[0], "xmark"] }
                        itemMarked.toggle()
                    }
                }) {
                    Text(itemMarked ? "Reset" : "Undo")
                },
            trailing:
                HStack {
                    Button(action: {
                        list.checklists[count].items = tempList
                        checklistItems = tempList
                        list.saveChecklist()
                    }) {
                        Text("Save")
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
