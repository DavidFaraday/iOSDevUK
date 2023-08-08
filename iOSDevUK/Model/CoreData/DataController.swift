//
//  DataController.swift
//  Project11
//
//  Created by David Kababyan on 20/10/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    /// Container that will manage synchronisation to local persistance store and to connected devices via Cloud Kit.
    let container = NSPersistentCloudKitContainer(name: "iOSDevUK")
    
    init() {
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    
    /// Checks is there is an existing entry in the managed object context for a session with the given id.
    /// - Parameters:
    ///   - id: The unique identifer for the session.
    ///   - context: The Core Data context that manages the store.
    /// - Returns: True if there is no record in the object context for the given id. Otherwise, false is returned. If there is an error, false is returned.
    static func entityExists(forId id: String, inContext context: NSManagedObjectContext) -> Bool {
        
        let existingRequest = NSFetchRequest<SavedSession>(entityName: "SavedSession")
        existingRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let existingSessions = try context.fetch(existingRequest)
            return !existingSessions.isEmpty
        }
        catch(let error) {
            print("Unable to access request for existing records: \(error.localizedDescription)")
        }
        
        return false
    }
    
    
    /// Save the data in the current managed object context.
    /// - Parameter context: The managed object context for this persistance store.
    static func save(context: NSManagedObjectContext) {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error saving to CD")
            }
        }
    }
}
