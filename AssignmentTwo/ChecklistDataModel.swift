//
//  DataModel.swift
//  AssignmentTwo
//
//  Created by Isaac Pollack on 30/3/2023.
//

import Foundation
///Checklist is built around JSON for data persistance purposes.
/// -
///It is both Hashable and Codable in nature.
struct Checklist: Hashable, Codable {
    ///Fully editable, reflecting in parent/sub menus in real-time.
    var name: String // Checklist Name
    var items: [[String]] // Array of sub-items
}

struct ChecklistDataModel: Codable {
    var checklists:[Checklist]

    init() {
        checklists = []
        loadChecklists()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(checklists, forKey: .checklists)
    }

    mutating func loadChecklists() {
        guard let path = getFile(),
            let data = try? Data(contentsOf: path),
            let datamodel = try? JSONDecoder().decode(ChecklistDataModel.self, from: data)
        else {
            self.checklists = defaultChecklists
            return
        }
        checklists = datamodel.checklists
    }

    func saveChecklists() {
        ///This is how we will store the data, in ``checklist.json``
        guard let path = getFile(),
              let data = try? JSONEncoder().encode(self)
        else {
            return
        }
        try? data.write(to: path)
    }
}

func getFile() -> URL? {
    ///This is how we will retrieve the data store, found  in ``func saveChecklist()``
    let fileName = "checklist.json"
    let fm = FileManager.default
    guard let path = fm.urls(for: .documentDirectory, in:
                                FileManager.SearchPathDomainMask.userDomainMask).first
    else {
        return nil
    }
    return path.appendingPathComponent(fileName)
}

var defaultChecklists: [Checklist] = [
    ///If the Checklist fails to retrieve the JSON data saved locally, this will populate it instead.
    Checklist(name: "Groceries", items: [["Bread", "square"], ["Milk", "square"], ["Apples", "square"], ["Oranges", "square"]]),
    Checklist(name: "Chores", items: [["Clean Kitchen", "square"], ["Take rubbish out", "square"], ["Do homework", "square"]])
]
