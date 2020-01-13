//
//  MockItemStorageMock.swift
//  MockAppTests
//
//  Created by Jeroen Rikhof on 13/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation
@testable import MockApp

final class MockItemStorageMock: MockItemStorage {
    
    var items: MockItems = []
    
    func loadItems() -> MockItems {
        return items
    }
    
    func store(items: MockItems) {
        self.items = items
    }
    
    func clear() {
        items = []
    }
}
