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
                    ForEach(model.lists.enumerated().map { $0 }, id: \.element) { (index, x) in
                        NavigationLink(destination: ListView(list: $model, count: index)) {
                            Text(x.name)
                        }
                    }
                    .onDelete { idx in
                        model.lists.remove(atOffsets: idx)
                        model.save()
                    }
                    .onMove { idx, i in
                        model.lists.move(fromOffsets: idx, toOffset: i)
                        model.saveChecklist()
                    }
                }.navigationTitle(checklistTitle)
                    .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                    model.lists.append(Checklist(name: "New List", tasks: [["New Task", "xmark"]]))
                    model.save()
                })
            }
        }
        .padding()
    }
}
