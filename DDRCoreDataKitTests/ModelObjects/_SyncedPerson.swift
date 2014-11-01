// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncedPerson.swift instead.

import CoreData

enum SyncedPersonAttributes: String {
    case ddrSyncIdentifier = "ddrSyncIdentifier"
    case firstName = "firstName"
    case lastName = "lastName"
}

@objc
class _SyncedPerson: DDRManagedObject {

    // MARK: - Class methods

    override class func entityName () -> String {
        return "SyncedPerson"
    }

    override class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _SyncedPerson.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var ddrSyncIdentifier: String?

    // func validateDdrSyncIdentifier(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var firstName: String?

    // func validateFirstName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var lastName: String?

    // func validateLastName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

}

