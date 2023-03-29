//
//  DetailView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var name: String
    @State var newName = ""
    @State var displayName = ""
    @State var originName = ""
    
    var body: some View {
        VStack {
            TitleView(title: displayName, icon: "person.circle")
            Text("You can enter a new name below:")
            TextField("<New Name>", text:$newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Change") {
                    if (newName != "") {
                        displayName = newName
                    }
                }
                Spacer()
                Button("Cancel") {
                    displayName = originName
                }
            }.padding()
            Spacer()
        }
        
        .padding()
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
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name:.constant("Isaac Pollack"))
    }
}
