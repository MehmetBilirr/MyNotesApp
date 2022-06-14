//
//  Note+CoreDataProperties.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 14.06.2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var text: String?

}

extension Note : Identifiable {

}
