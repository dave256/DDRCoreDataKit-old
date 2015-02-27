//
//  DDRCoreDataDocument.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/13/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

import CoreData

public class DDRCoreDataDocument: NSObject {

    public let mainQueueMOC : NSManagedObjectContext!
    private let managedObjectModel : NSManagedObjectModel
    private let persistentStoreCoordinator : NSPersistentStoreCoordinator
    private var storeURL : NSURL! = nil

    // private data
    private var privateMOC : NSManagedObjectContext! = nil

    public init(storeURL: NSURL?, modelURL: NSURL, options : NSDictionary) {
        managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        var storeType : String = (storeURL != nil) ? NSSQLiteStoreType : NSInMemoryStoreType

        var addError : NSError? = nil
        if !(persistentStoreCoordinator.addPersistentStoreWithType(storeType, configuration: nil, URL: storeURL, options: options as [NSObject : AnyObject], error: &addError) != nil) {
            if let error = addError {
                println("Error adding persitent store to coordinator \(error.localizedDescription) \(error.userInfo!)")

            }
            mainQueueMOC = nil
            privateMOC = nil

        } else {
            self.storeURL = storeURL
            privateMOC = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
            privateMOC!.persistentStoreCoordinator = persistentStoreCoordinator
            privateMOC!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            mainQueueMOC = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
            mainQueueMOC!.persistentStoreCoordinator = persistentStoreCoordinator
            mainQueueMOC!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        }
        super.init()
    }

    public func saveContext(wait: Bool, error : NSErrorPointer) -> Bool {
        if mainQueueMOC == nil {
            return false
        }

        if mainQueueMOC.hasChanges {
            mainQueueMOC.performBlockAndWait {
                var saveError : NSError? = nil
                if self.mainQueueMOC.save(&saveError) {
                    if let theError = saveError {
                        println("error saving mainQueueMOC: \(theError.localizedDescription)")
                        if error != nil {
                            error.memory = theError
                        }
                    }
                }
            }
        }

        var saveClosure : () -> () = {
            var saveError : NSError? = nil
            if self.privateMOC.save(&saveError) {
                if let theError = saveError {
                    println("error saving privateMOC: \(theError.localizedDescription)")
                    if error != nil {
                        error.memory = theError
                    }
                }
            }
        }

        if error != nil {
            if privateMOC.hasChanges {
                if wait {
                    privateMOC.performBlockAndWait(saveClosure)
                }
                else {
                    privateMOC.performBlock(saveClosure)
                }
            }
        }

        if error != nil {
            return false
        } else {
            return true
        }
    }

    
    public func newChildOfMainObjectContextWithConcurrencyType(concurrencyType : NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        var moc = NSManagedObjectContext(concurrencyType: concurrencyType)
        moc.parentContext = mainQueueMOC
        return moc
    }
}
