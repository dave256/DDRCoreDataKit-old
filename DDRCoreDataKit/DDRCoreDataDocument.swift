//
//  DDRCoreDataDocument.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/13/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

import CoreData

class DDRCoreDataDocument: NSObject {

    let mainQueueObjectContext : NSManagedObjectContext?
    let managedObjectModel : NSManagedObjectModel
    let persistentStoreCoordinator : NSPersistentStoreCoordinator
    let storeURL : NSURL?

    // private data
    let privateMOC : NSManagedObjectContext?

    init(storeURL: NSURL?, modelName: String, options : NSDictionary) {
        var bundle = NSBundle(forClass: DDRCoreDataDocument.self)
        var modelURL = bundle.URLForResource(modelName, withExtension: "momd")
        managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        var storeType : String
        if let sURL = storeURL {
            storeType = NSSQLiteStoreType
        } else {
            storeType = NSInMemoryStoreType
        }
        var addError : NSError? = nil
        if !persistentStoreCoordinator.addPersistentStoreWithType(storeType, configuration: nil, URL: storeURL, options: options, error: &addError) {
            if let error = addError {
                println("Error adding persitent store to coordinator \(error.localizedDescription) \(error.userInfo!)")

            }
            mainQueueObjectContext = nil
            privateMOC = nil

        } else {
            self.storeURL = storeURL
            privateMOC = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
            privateMOC!.persistentStoreCoordinator = persistentStoreCoordinator
            privateMOC!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            mainQueueObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
            mainQueueObjectContext!.persistentStoreCoordinator = persistentStoreCoordinator
            mainQueueObjectContext!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        }
        super.init()
    }

    func saveContext(wait: Bool) {
        if mainQueueObjectContext == nil {
            return
        }

        if mainQueueObjectContext?.hasChanges {
            mainQueueObjectContext?.performBlockAndWait {
                var saveError : NSError? = nil
                if self.mainQueueObjectContext?.save(&saveError) {
                    if let error = saveError {
                        println("error saving mainQueueObjectContext: \(error.localizedDescription)")
                    }
                }
            }
        }

        var saveClosure : () -> () = {
            var saveError : NSError? = nil
            if self.privateMOC?.save(&saveError) {
                if let error = saveError {
                    println("error saving privateMOC: \(error.localizedDescription)")
                }
            }

        }

        if privateMOC?.hasChanges {
            if wait {
                privateMOC?.performBlockAndWait(saveClosure)
            }
            else {
                privateMOC?.performBlock(saveClosure)
            }
        }
    }

    func newChildOfMainObjectContextWithConcurrencyType(concurrencyType : NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        var moc = NSManagedObjectContext(concurrencyType: concurrencyType)
        moc.parentContext = mainQueueObjectContext
        return moc
    }
}
