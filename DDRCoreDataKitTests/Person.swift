//
//  Person.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/13/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

import CoreData
import DDRCoreDataKit

// this really should be a subclass of DDRManagedObject but just testing that it does not crash
// when no ddrSyncIdentifier attribute (just logs an error message)
// @objc(Person) is required or entityName() in the DDRManagedObject class does not work correctly

@objc(Person) class Person : DDRSyncedManagedObject  {

    @NSManaged var firstName : NSString
    @NSManaged var lastName : NSString

}
