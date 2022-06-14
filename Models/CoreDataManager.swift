//
//  CoreDataManager.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 14.06.2022.
//

import Foundation
import CoreData


class CoreDataManager {
    
    
    static let shared = CoreDataManager(modelName: "MyNotesApp")
    let persistantContainer : NSPersistentContainer
    var viewContext : NSManagedObjectContext{
        return persistantContainer.viewContext
    }
    init(modelName:String) {
        persistantContainer = NSPersistentContainer(name: modelName)
        
    }
    
    func load(completion: (() -> Void)? = nil) {
        
        persistantContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
                
            }
            completion?()
            
        }
        
        
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                
                try viewContext.save()
            }catch {
                print("An error occured while saving: \(error.localizedDescription)")
            }
            
        }
    }
}

// Mark: Helperf functions

extension CoreDataManager {
    func createNote() -> Note {
        
        let note = Note(context: viewContext)
        
        note.id = UUID()
        note.text = ""
        note.lastUpdated = Date()
        save()
        
        return note
    }
    
    func fethNotes(filter:String? = nil) -> [Note] {
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return (try? viewContext.fetch(request)) ?? []
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
            
        }
    }
    
    func deleteNote(_ note:Note) {
        viewContext.delete(note
    )
    }
    
}
