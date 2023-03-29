//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

let checklistContents = [
["Ham"],
["Cheese"],
["Bread"],
["Iphone"],
["Watch"]
]

struct ContentView: View {
    var title: String

    var body: some View {
        //NavView: A container that adds stack-based nav with a title bar
        NavigationView {
            Text(title).font(.title)
                .foregroundColor(.white)
                .padding()
            List {
                ForEach(checklistContents, id:\.self) {
                    checklist in
                    //NavigationLink(destination: DetailView(checklist: checklist)) {
                        //ListView(checklist: checklist)
                    }
                }
            }.listStyle(InsetListStyle())
        }
    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Master Checklist")
    }
}
