//
//  DetailView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct DetailView: View {
    @State var name: String
    @State var newName = ""
    @State var originName = ""

    var body: some View {
        
        VStack {
            TitleView(title: name)
            Text("You can enter a new name below:")
            TextField("New Name", text: $newName)
            Spacer()
            HStack {
                Button("Change") {
                    if (newName != "") {
                        name = newName
                    }
                }
                Spacer()
                Button("Cancel") {
                    name = originName
                }.padding()
                Spacer()
            }.padding()
                .onAppear{name = originName}
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Isaac")
    }
}
