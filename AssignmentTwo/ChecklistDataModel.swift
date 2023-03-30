//
//  DataModel.swift
//  AssignmentTwo
//
//  Created by Isaac Pollack on 30/3/2023.
//

import Foundation

struct Checklist: Hashable, Codable {
    //This will be used for JSON storage
    var name: String = "<unknown>"
}

var defaultChecklists = [
    Checklist(name: "Groceries"),
    Checklist(name: "Chores")
]

struct ChecklistDataModel: Codable {
    var checklists:[Checklist]
    
    enum CodingKeys : CodingKey {
        case checklists
    }
    enum FileError: Error {
        case dirNotFound
    }
    
    static var fileurl: URL {
        get throws {
            let fileName = "checklist.json"
            let fm = FileManager.default
            guard let path = fm.urls(for: .documentDirectory, in:
                                        FileManager.SearchPathDomainMask.userDomainMask).first
            else {
                throw FileError.dirNotFound
            }
            return path.appendingPathComponent(fileName)
        }
    }
    
    init() {
        checklists = []
        loadChecklist()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(checklists, forKey: .checklists)
    }
    
    mutating func loadChecklist() {
        guard let fileurl = try? ChecklistDataModel.fileurl,
              let data = try? Data(contentsOf: fileurl),
              let datamodel = try? JSONDecoder().decode(ChecklistDataModel.self, from: data)
        else {
            self.checklists = defaultChecklists
            return
        }
        checklists = datamodel.checklists
    }
    
    func saveChecklist() {
        do {
            let data = try JSONEncoder().encode(self)
            let url = try ChecklistDataModel.fileurl
            print("filepath:", url)
            try data.write(to: url, options: .atomic)
        } catch {
            print("I got an error: ", error)
        }
    }
}