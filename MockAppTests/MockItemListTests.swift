//
//  MockItemListTests.swift
//  MockAppTests
//
//  Created by Jeroen Rikhof on 13/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import XCTest
@testable import MockApp

class MockItemListTests: XCTestCase {

    var sut: MockItemList!
    
    var storageMock: MockItemStorageMock!
    var serviceMock: MockItemServiceMock!
    
    override func setUp() {
        storageMock = MockItemStorageMock()
        serviceMock = MockItemServiceMock()
        
        sut = MockItemList(mockItemStorage: storageMock,
                           mockItemService: serviceMock)
    }

    func testMockListErrorIsNilAfterInitiation() {
        XCTAssertNil(sut.error)
    }
    
    func testMockListItemsIsEmptyAfterInitiation() {
        XCTAssertTrue(sut.items.isEmpty)
    }
    
    func testMockListLoadItems() {
        sut.loadItems()
        
        let exp = expectation(description: "mockItemStorage")
        DispatchQueue.main.async {
            XCTAssertEqual(self.storageMock.items.count, 10)
            XCTAssertEqual(self.sut.items.count, 10)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testMockListItemAppearsFirstItem() {
        storageMock.items = Array(MockData.allItems[0..<10])
        
        sut.loadItems()
        sut.itemAppears(sut.items.first!) // Initial load will be ignored
        sut.itemAppears(sut.items.first!)
        
        let exp = expectation(description: "mockItemStorage")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.serviceMock.sinceId, "30")
            XCTAssertEqual(self.sut.items.count, 10) // We don't have new items
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testMockListItemAppearsOtherItem() {
        storageMock.items = Array(MockData.allItems[0..<10])
        
        sut.loadItems()
        sut.itemAppears(sut.items[4])
        
        let exp = expectation(description: "mockItemStorage")
        DispatchQueue.main.async {
            XCTAssertNil(self.serviceMock.sinceId)
            XCTAssertNil(self.serviceMock.maxId)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testMockListItemAppearsLastItem() {
        storageMock.items = Array(MockData.allItems[0..<10])
        
        sut.loadItems()
        sut.itemAppears(sut.items.last!)
        
        let exp = expectation(description: "mockItemStorage")
        DispatchQueue.main.async {
            XCTAssertEqual(self.serviceMock.maxId, "21")
            XCTAssertEqual(self.sut.items.count, 20)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

}
