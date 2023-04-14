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
        NavigationView {
            List {
                ForEach(model.checklists.enumerated().map{ $0 }, id:\.self) { (index, p) in
                    NavigationLink(destination: DetailView(name: .constant(checklist.name))) {
                        Text(checklist.name)
                    }
                }.onDelete {
                    //Remove the item that the minus was tapped on
                    indecs in
                    model.checklists.remove(atOffsets: indecs)
                    model.saveChecklist()
                }
            }.navigationBarItems(leading: EditButton(), trailing: Button("+") {
                //Append a new checklist item when clicked
                let newChecklist = Checklist(name: "New Checklist\(model.checklists.count)")
                model.checklists.append(newChecklist)
                model.saveChecklist()
            }).navigationTitle("My Checklists")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
