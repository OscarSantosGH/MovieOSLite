//
//  PersistenceManager.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager{
    
    static let shared = PersistenceManager(modelName: "MovieOS")
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init(modelName:String){
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil){
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else{
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func saveOrRollback(){
        do{
            try viewContext.save()
        }catch{
            viewContext.rollback()
        }
    }
    
}
