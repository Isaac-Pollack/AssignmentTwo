//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var model: ChecklistDataModel
    @State var checklistTitle = "My Checklists"

    var body: some View {
        NavigationView() {
            VStack {
                EditView(item: $checklistTitle)
                List {
                    ForEach(model.checklists.enumerated().map { $0 }, id: \.element) { (index, x) in
                        NavigationLink(destination: ListView(list: $model, count: index)) {
                            Text(x.name)
                        }
                    }
                    .onDelete { indices in
                        model.checklists.remove(atOffsets: indices)
                        model.saveChecklists()
                    }
                    .onMove { indices, i in
                        model.checklists.move(fromOffsets: indices, toOffset: i)
                        model.saveChecklists()
                    }
                }.navigationTitle(checklistTitle)
                    .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                        model.checklists.append(Checklist(name: "New List", items: [["New Item", "xmark"]]))
                    model.saveChecklists()
                })
            }
        }
        .padding()
    }
}
