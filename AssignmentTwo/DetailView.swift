//
//  DetailView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct Item: Hashable {
    //This will be used for JSON down the track
    var name: String = "<unknown>"
}

struct DetailView: View {
    @Binding var name: String
    @State var newName = ""
    @State var displayName = ""
    @State var originName = ""
    
    @State var isEditing = false
    
    @State var ChecklistItem = [
        Item(name:"Apple")]
    
    var body: some View {
        NavigationView {
                VStack {
                    Text(displayName).font(.largeTitle)
                    
                    //TextField("<New Name>", text:$newName)
                    List {
                        ForEach($ChecklistItem, id:\.self) {
                            $Item in
                            Text(Item.name)
                        }.navigationBarItems(
                            leading:
                                HStack {
                                    EditButton()
                                },
                            trailing:
                                HStack {
                                    Button("Apply") {
                                        if (newName != "") {
                                            displayName = newName
                                        }
                                    }
                                    Button("Reset") {
                                        displayName = originName
                                    }.foregroundColor(Color.red)
                                })
                    }
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
    }

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name:.constant("Groceries"))
    }
}
