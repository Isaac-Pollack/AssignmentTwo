//
//  AssignmentTwoApp.swift
//  AssignmentTwo
//
//  Created by Isaac Pollack on 24/3/2023.
//

import SwiftUI

@main

struct AssignmentTwoApp: App {
    @State var model:DataModel = ChecklistDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView(model: $model)
        }
    }
}
