//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    @State var scientists = ["Isaac Newton", "Albert Einstein", "Archimedes"]
    
    var body: some View {
        NavigationView {
            VStack{
                TitleView(title:"Great Scientists", icon: "person.3.fill")
                List {
                    ForEach($scientists, id:\.self) {
                        $person in
                        NavigationLink(destination: DetailView(name: $person)) {
                            Text(person)
                        }
                    }
                }
                Spacer()
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
