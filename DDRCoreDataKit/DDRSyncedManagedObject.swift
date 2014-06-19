//
//  DDRSyncedManagedObject.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/19/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

class DDRSyncedManagedObject : DDRManagedObject {

    override func awakeFromInsert() {
        super.awakeFromInsert()
        if !self.valueForKey("ddrSyncIdentifier") {
            self.setValue(NSUUID.UUID().UUIDString, forKey: "ddrSyncIdentifier")
        }
    }

    override func valueForUndefinedKey(key: String!) -> AnyObject! {
        if key == "ddrSyncIdentifier" {
            NSLog("no ddrSyncIdentifier for object of type")
        } else {
            super.valueForUndefinedKey(key)
        }
        return nil
    }

    override func setValue(value: AnyObject!, forUndefinedKey key: String!) {
        if key == "ddrSyncIdentifier" {
            NSLog("no ddrSyncIdentifier for object of type")
        } else {
            super.setValue(value, forUndefinedKey: key)
        }
    }

}

