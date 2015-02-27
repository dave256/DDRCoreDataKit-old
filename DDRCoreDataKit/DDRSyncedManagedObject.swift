//
//  DDRSyncedManagedObject.swift
//  DDRCoreDataKit
//
//  Created by David Reed on 6/19/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

// after switching to MOGenerator, they inherict from DDRManagedObject
// so just copy these methods into the non-generated file

public class DDRSyncedManagedObject : DDRManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        var desc = self.entity
        if desc.attributesByName["ddrSyncIdentifier"] != nil {
            self.setValue(NSUUID().UUIDString, forKey: "ddrSyncIdentifier")
        }
    }

    public override func valueForUndefinedKey(key: String) -> AnyObject {
        if key == "ddrSyncIdentifier" {
            println("no ddrSyncIdentifier for object of type")
        } else {
            super.valueForUndefinedKey(key)
        }
        return ""
    }

    public override func setValue(value: AnyObject!, forUndefinedKey key: String) {
        if key == "ddrSyncIdentifier" {
            println("no ddrSyncIdentifier for object of type")
        } else {
            super.setValue(value, forUndefinedKey: key)
        }
    }

}

