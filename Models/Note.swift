//
//  Note.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 14.06.2022.
//

import Foundation


class Note {
    let id = UUID()
    var text: String = ""
    var lastUpdated:Date = Date()
    
    var title:String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
    }
    
    var desc:String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated.format()) \(lines.first ?? "")"
    }
}
