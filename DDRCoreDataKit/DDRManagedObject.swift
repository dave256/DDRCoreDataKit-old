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

updated to now work with MOGenerator

put code such as the following in a Run Script build phase and move it before the compile step
cd "$PROJECT_DIR/DDRCoreDataKitTests" && /usr/local/bin/mogenerator --swift -m DDRCoreDataTests.xcdatamodeld/DDRCoreDataTests.xcdatamodel --base-class DDRManagedObject --output-dir ./ModelObjects
*/
public class DDRManagedObject: NSManagedObject {


    // overriden by MOGenerator generated base class
    class func entityName() -> String {
        return ""
    }

    // overriden by MOGenerator generated base class
    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return nil // NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
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
