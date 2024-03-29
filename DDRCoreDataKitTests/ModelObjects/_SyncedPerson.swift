// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncedPerson.swift instead.

import CoreData

enum SyncedPersonAttributes: String {
    case ddrSyncIdentifier = "ddrSyncIdentifier"
    case firstName = "firstName"
    case lastName = "lastName"
}

@objc public
class _SyncedPerson: DDRManagedObject {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "SyncedPerson"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

	public
    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _SyncedPerson.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var ddrSyncIdentifier: String?

    // func validateDdrSyncIdentifier(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged public
    var firstName: String?

    // func validateFirstName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged public
    var lastName: String?

    // func validateLastName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

}

