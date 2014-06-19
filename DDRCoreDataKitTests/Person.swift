//
//  Person.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/13/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

import CoreData
import DDRCoreDataKit

@objc(Person) class Person : DDRManagedObject  {

    @NSManaged var firstName : NSString
    @NSManaged var lastName : NSString

}
