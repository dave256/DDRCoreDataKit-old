import Foundation

@objc(SyncedPerson)
class SyncedPerson: _SyncedPerson {

	// Custom logic goes here.
    override func awakeFromInsert() {
        super.awakeFromInsert()
        var desc = self.entity
        if desc.attributesByName["ddrSyncIdentifier"] != nil {
            self.setValue(NSUUID().UUIDString, forKey: "ddrSyncIdentifier")
        }
    }

    override func valueForUndefinedKey(key: String) -> AnyObject {
        if key == "ddrSyncIdentifier" {
            NSLog("no ddrSyncIdentifier for object of type")
        } else {
            super.valueForUndefinedKey(key)
        }
        return ""
    }

    override func setValue(value: AnyObject!, forUndefinedKey key: String) {
        if key == "ddrSyncIdentifier" {
            NSLog("no ddrSyncIdentifier for object of type")
        } else {
            super.setValue(value, forUndefinedKey: key)
        }
    }

}
