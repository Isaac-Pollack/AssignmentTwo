//
//  ListView.swift
//  AssignmentOne
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct TickBoxStyle: ToggleStyle {
    //Extend on ToggleStyle : makeBody for styling
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

struct ListView: View {
    var checklist:[String]
    @State var itemBought = false

    var body: some View {
        HStack {
            Text(checklist[0])
                .font(.title2)
                .frame(width:80, height: 35)
                .background(.blue)
            Toggle(isOn: $itemBought, label: {})
                .toggleStyle(TickBoxStyle())
            Spacer()
        }
    }
}
