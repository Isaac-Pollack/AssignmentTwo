//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct Checklist: Hashable {
    //This will be used for JSON down the track
    var name: String = "<unknown>"
}

struct ContentView: View {
    //Default Checklists
    @State var myChecklists = [
        Checklist(name:"Groceries"),
    ]
    var body: some View {
        NavigationView {
            //Navlink to each checklist created
            List {
                ForEach($myChecklists, id:\.self) {
                    $checklist in
                    NavigationLink(destination: DetailView(name: $checklist.name)) {
                        Text(checklist.name)
                    }
                }.onDelete {
                    //Remove the item tapped
                    indecs in
                    myChecklists.remove(atOffsets: indecs)
                }
            }.navigationBarItems(leading: EditButton(), trailing: Button("+") {
                //Append a new checklist item when clicked
                let newChecklist = Checklist(name: "New Checklist\(myChecklists.count)")
                myChecklists.append(newChecklist)
            }).navigationTitle("My Checklists")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
