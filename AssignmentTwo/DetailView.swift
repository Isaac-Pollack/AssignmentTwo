//
//  DetailView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct Item: Hashable {
    //This will be used for JSON down the track, for data persistance.
    var name: String = "<unknown>"
}

struct DetailView: View {
    @Binding var name: String
    @State var newName = ""
    @State var displayName = ""
    @State var originName = ""
    
    @State var ChecklistItem = [
        Item(name:"Apple"),
        Item(name:"Orange"),
        Item(name:"Banana"),
        Item(name:"Watermelon")
    ]
    
    @State var mode: EditMode = .inactive
    @State var itemBought = false
    
    //Custom tick box style for list items
    struct TickBoxStyle: ToggleStyle {
        //Extend on ToggleStyle : makeBody func
        func makeBody(configuration: Configuration) -> some View {
            return HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(configuration.isOn ? .green : .gray)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            }
        }
    }
    
    var body: some View {
        NavigationView {
                VStack {
                    //Display this entire HStack if the edit mode is ON
                    if(mode == .active) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                            TextField("<New Checklist Name>", text:$newName)
                            //Apply name change button
                            Button("Apply") {
                                if (newName != "") {
                                    displayName = newName
                                }
                            }
                            
                            //Reset back to origin name
                            Button("Reset") {
                                displayName = originName
                            }.foregroundColor(Color.red)
                        }.padding()
                    }
                    List {
                        ForEach($ChecklistItem, id:\.self) {
                            $Item in
                            HStack {
                                Text(Item.name)
                                    .font(.title2)
                                Toggle(isOn: $itemBought, label: {})
                                    .toggleStyle(TickBoxStyle())
                                Spacer()
                            }
                        }
                        .onDelete { ChecklistItem.remove(atOffsets: $0) }
                        .onMove { ChecklistItem.move(fromOffsets: $0, toOffset: $1) }
                    }.navigationTitle(displayName)
                        .navigationBarTitleDisplayMode(.automatic)
                        .toolbar {
                            //Default Edit/one Button
                            EditButton()
                        }.environment(\.editMode, $mode)
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
