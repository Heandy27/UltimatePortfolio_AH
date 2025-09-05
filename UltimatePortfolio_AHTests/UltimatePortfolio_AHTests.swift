//
//  UltimatePortfolio_AHTests.swift
//  UltimatePortfolio_AHTests
//
//  Created by Andy Heredia on 5/9/25.
//
import CoreData
import XCTest
@testable import UltimatePortfolio_AH

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
