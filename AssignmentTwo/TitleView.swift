//
//  TitleView.swift
//  AssignmentTwo
//
//  Created by Isaac Pollack on 24/3/2023.
//

import SwiftUI

struct TitleView: View {
    var title: String
    var icon: String?
    var body: some View {
        HStack{
            Text(title).font(.title)
                .padding()
                .foregroundColor(.white)
            Spacer()
            Image(systemName: icon ?? "")
                .imageScale(.large)
                .padding()
                .foregroundColor(.white)
        }.background(.blue)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Title View", icon: "person.circle")
    }
}
