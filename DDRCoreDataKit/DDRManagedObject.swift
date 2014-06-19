//
//  DDRManagedObject.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/13/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

import CoreData

// subclasses must use syntax:
// @objc(Person) class Person : DDRManagedObject
// otherwise entityName method will not work
class DDRManagedObject: NSManagedObject {

    class func newInstanceInManagedObjectContext(context: NSManagedObjectContext) -> AnyObject {
        return NSEntityDescription.insertNewObjectForEntityForName(self.entityName(), inManagedObjectContext: context)
    }

    class func entityName() -> String {
        return NSStringFromClass(self)
    }

    class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: entityName())
    }

    class func allInstancesWithPredicate(predicate: NSPredicate?, sortDescriptors : NSSortDescriptor[]?, inManagedObjectContext moc: NSManagedObjectContext) -> AnyObject[]! {
        var request = self.fetchRequest()

        if let pred = predicate {
            request.predicate = pred
        }
        if let sorters = sortDescriptors {
            request.sortDescriptors = sorters
        }
        var executeError : NSError? = nil
        var results = moc.executeFetchRequest(request, error: &executeError)
        if let error = executeError {
            println("Error loading \(request) \(predicate) \(error)")
        }
        return results
    }

    class func allInstancesWithPredicate(predicate: NSPredicate?, inManagedObjectContext moc: NSManagedObjectContext) -> AnyObject[]! {
        return allInstancesWithPredicate(predicate, sortDescriptors: nil, inManagedObjectContext: moc)
    }

    class func allInstances(managedObjectContext moc : NSManagedObjectContext) -> AnyObject[]! {
        return self.allInstancesWithPredicate(nil, inManagedObjectContext: moc)
    }

}