//
//  DetailView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct DetailView: View {
    //Checklists
    @Binding var list: ChecklistDataModel
    @State var mode: EditMode = .inactive
    @State var newName = ""
    @State var displayName = ""
    @State var originName = ""
    
    //Sub-Items
    var count: Int
    @State var itemMarked = false
    @State var newItem = ""
    @State var listItems: [[String]] = []
    
    var body: some View {
        VStack {
            List
            
            List {
                ForEach($ChecklistItem, id:\.self) {
                    $Item in
                    HStack {
                        Text(Item.name)
                            .font(.title2)
                        Toggle(isOn: $itemBought, label: {})
                            .toggleStyle(TickBoxStyle())
                        Spacer()
                    }
                }
                .onDelete { ChecklistItem.remove(atOffsets: $0) }
                .onMove { ChecklistItem.move(fromOffsets: $0, toOffset: $1) }
            }.navigationTitle(displayName)
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    //Default Edit/one Button
                    EditButton()
                }.environment(\.editMode, $mode)
        }
    }
        .onAppear {
            //Set initial value to below preview/binded 'name'
            originName = name
            displayName = name
        }
        .onDisappear {
            //When we leave the view; set the name to the changed value
            name = displayName
        }
}
