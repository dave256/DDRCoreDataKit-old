//
//  DDRCoreDataKitTests.swift
//  DDRCoreDataKitTests
//
//  Created by David Reed on 6/13/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

import XCTest
import CoreData
import DDRCoreDataKit

class DDRCoreDataKitTests: XCTestCase {

    var storeURL : NSURL? = nil
    var doc : DDRCoreDataDocument? = nil

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        storeURL = NSURL(fileURLWithPath: NSTemporaryDirectory().stringByAppendingPathComponent("test.sqlite"))
        doc = DDRCoreDataDocument(storeURL: storeURL, modelName: "DDRCoreDataTests", options: NSDictionary())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        NSFileManager().removeItemAtURL(storeURL, error: nil)
    }

    /*
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    */

    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
*/

    func testInsertionOfPersonObjects() {
        var moc = doc?.mainQueueObjectContext

        if let mainMOC = moc {
            insertDaveReedInManagedObjectContext(mainMOC)
            insertDaveSmithInManagedObjectContext(mainMOC)
            insertJohnStroehInManagedObjectContext(mainMOC)

            var sorters = [NSSortDescriptor(key: "lastName", ascending: true), NSSortDescriptor(key: "firstName", ascending: true)]
            var predicate = NSPredicate(format: "%K=%@", "firstName", "Dave")
            var items = Person.allInstancesWithPredicate(predicate, sortDescriptors: sorters, inManagedObjectContext: mainMOC)
            XCTAssertEqual(items.count, 2, "items.count is not 2")
        }
    }

    func insertDaveReedInManagedObjectContext(moc: NSManagedObjectContext) {
        var p = Person.newInstanceInManagedObjectContext(moc) as Person
        p.firstName = "Dave"
        p.lastName = "Reed"
    }


    func insertDaveSmithInManagedObjectContext(moc: NSManagedObjectContext) {
        var p = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: moc) as Person
        p.firstName = "Dave"
        p.lastName = "Smith"
    }

    func insertJohnStroehInManagedObjectContext(moc: NSManagedObjectContext) {
        var p = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: moc) as Person
        p.firstName = "John"
        p.lastName = "Stroeh"
    }

}
