//
//  DDRSyncedManagedObject.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/19/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

public class DDRSyncedManagedObject : DDRManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        if !self.valueForKey("ddrSyncIdentifier") {
            self.setValue(NSUUID.UUID().UUIDString, forKey: "ddrSyncIdentifier")
        }
    }

    public override func valueForUndefinedKey(key: String!) -> AnyObject! {
        if key == "ddrSyncIdentifier" {
            NSLog("no ddrSyncIdentifier for object of type")
        } else {
            super.valueForUndefinedKey(key)
        }
        return nil
    }

    public override func setValue(value: AnyObject!, forUndefinedKey key: String!) {
        if key == "ddrSyncIdentifier" {
            NSLog("no ddrSyncIdentifier for object of type")
        } else {
            super.setValue(value, forUndefinedKey: key)
        }
    }

}

