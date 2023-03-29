//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct Checklist: Hashable {
    var name:String = "<unknown>"
}

struct ContentView: View {
    @State var myChecklists = [
        Checklist(name:"Groceries"),
        Checklist(name:"Chores"),
        Checklist(name:"Packing List")
    ]
    var body: some View {
        NavigationView {
            List {
                ForEach(myChecklists, id:\.self) {
                    checklist in
                    Text(checklist.name)
                }.onDelete {
                    indecs in
                    myChecklists.remove(atOffsets: indecs)
                }
            }.navigationBarItems(leading: EditButton(), trailing: Button("+"){
                let newChecklist = Checklist(name: "New Checklist\(myChecklists.count)")
                myChecklists.append(newChecklist)
            }).navigationTitle("My Checklists")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
