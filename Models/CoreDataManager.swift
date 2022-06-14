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
}

// Mark: Helperf functions


