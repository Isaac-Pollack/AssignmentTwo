//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var model:ChecklistDataModel
    @State var viewTitle: String = "Checklist App"

    var body: some View {
        NavigationView() {
            VStack {
                EditView(item: $viewTitle)
                List {
                    ForEach(model.lists.enumerated().map { $0 }, id: \.element) { (index, x) in
                        NavigationLink(destination: ListView(list: $model, count: index)) {
                            Text(x.name)
                        }
                    }
                    .onDelete { indices in
                        model.lists.remove(atOffsets: indices)
                        model.save()
                    }
                    .onMove { indices, i in
                        model.lists.move(fromOffsets: indices, toOffset: i)
                        model.save()
                    }
                }.navigationTitle(viewTitle)
                    .navigationBarItems(leading: EditButton(), trailing: Button("+") {
                    model.lists.append(Checklist(name: "New List", tasks: [["New Task", "xmark"]]))
                    model.save()
                })
            }
        }
        .padding()
    }
}
