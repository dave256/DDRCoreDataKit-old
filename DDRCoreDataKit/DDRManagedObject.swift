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

/** DDRManagedObject is a standard subclass of NSManagedObject with convenience methods for creating new instances and fetch requests
note: subclass must use the syntax: @objc(Person) class Person : DDRSyncedManagedObject
when creating a subclass otherise the entityName method will not work
*/
public class DDRManagedObject: NSManagedObject {

    /**
    returns a newly inserted NSManagedObject. when using with your own subclass cast using name of your subclass
    var Person p = Person.newInstanceInManagedObjectContext(moc) as Person
    @param context NSManagedObjectContext to insert the object into
    @return a newly inserted NSManagedObject subclass in the specified context
    */
    public class func newInstanceInManagedObjectContext(context: NSManagedObjectContext) -> AnyObject {
        return NSEntityDescription.insertNewObjectForEntityForName(self.entityName(), inManagedObjectContext: context)
    }

    public class func entityName() -> String {
        return NSStringFromClass(self)
    }

    public class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: entityName())
    }

    public class func allInstancesWithPredicate(predicate: NSPredicate?, sortDescriptors : [NSSortDescriptor]?, inManagedObjectContext moc: NSManagedObjectContext) -> [AnyObject]! {
        var request = self.fetchRequest()

        // set fetch request predicte if passed in
        if let pred = predicate {
            request.predicate = pred
        }

        // set fetch request sort descriptors if passed in
        if let sorters = sortDescriptors {
            request.sortDescriptors = sorters
        }

        // execute request
        var executeError : NSError? = nil
        var results = moc.executeFetchRequest(request, error: &executeError)
        if let error = executeError {
            println("Error loading \(request) \(predicate) \(error)")
        }

        // return array of NSManagedObjects (or array of subclass of NSManagedObjects)
        return results
    }

    public class func allInstancesWithPredicate(predicate: NSPredicate?, inManagedObjectContext moc: NSManagedObjectContext) -> [AnyObject]! {
        return allInstancesWithPredicate(predicate, sortDescriptors: nil, inManagedObjectContext: moc)
    }

    public class func allInstances(managedObjectContext moc : NSManagedObjectContext) -> [AnyObject]! {
        return self.allInstancesWithPredicate(nil, sortDescriptors: nil, inManagedObjectContext: moc)
    }

}
