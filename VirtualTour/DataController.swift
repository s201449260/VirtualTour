//
//  DataController.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 10/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import Foundation

import CoreData

class DataController {
    
    static let shared = DataController()
    
    let persistentContainer = NSPersistentContainer(name: "VirtualTour")
    
    var viewContext : NSManagedObjectContext {
        
        return persistentContainer.viewContext
    }
    
    func load() {
        
        persistentContainer.loadPersistentStores{
            (storeDescription , error) in guard  error == nil else {
                fatalError(error!.localizedDescription)
            }
            
            
        }
        
    }
    
    
    
}
