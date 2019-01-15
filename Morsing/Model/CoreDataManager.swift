//
//  CoreDataManager.swift
//  Morsing
//
//  Created by Paloma Bispo on 12/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "Morsing")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext{
        return self.persistentContainer.viewContext
    }
    
    func getEntityDescription(entityName: String) -> NSEntityDescription?{
        let context = self.getContext()
        guard let description = NSEntityDescription.entity(forEntityName: entityName, in: context) else {return nil}
        return description
    }
    
    func fetching(isLetterData: Bool) -> [NSManagedObject]?{
        if isLetterData{
            guard let entity = CoreDataManager.shared.getEntityDescription(entityName: "Letters") else {return nil}
            let result = CoreDataManager.shared.getAll(entity: entity)
            if result.success{
                return result.objects
            }else{
                return nil
            }
            
        }else{
            guard let entity = CoreDataManager.shared.getEntityDescription(entityName: "Numbers") else {return nil}
            let result = CoreDataManager.shared.getAll(entity: entity)
            if result.success{
                return result.objects
            }else{
                return nil
            }
        }
    }
    
    private func getAll(entity: NSEntityDescription) -> (success: Bool, objects: [NSManagedObject]){
        let context = self.getContext()
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        var result: [NSManagedObject]?
        do{
            result = try context.fetch(request) as? [NSManagedObject]
            return (true, result!)
        }catch{
            print("Error in fetch objects")
            return (false, result!)
        }
        
        
    }
    

}
