//
//  SyncedPerson.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/19/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

import CoreData
import DDRCoreDataKit

@objc(SyncedPerson) class SyncedPerson : DDRSyncedManagedObject  {

    @NSManaged var firstName : NSString
    @NSManaged var lastName : NSString
    @NSManaged var ddrSyncIdentifier : NSString
    
}
