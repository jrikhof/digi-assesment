//
//  MockItemServiceMock.swift
//  MockAppTests
//
//  Created by Jeroen Rikhof on 13/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation
@testable import MockApp

class MockItemServiceMock: MockItemService {
    
    var error: Error?
    var items: MockItems = MockData.allItems
    
    private(set) var sinceId: String?
    private(set) var maxId: String?
    
    func fetchMockItems(sinceId: String?,
                        maxId: String?,
                        completion: @escaping (Result<MockItems, Error>) -> Void) {
        self.sinceId = sinceId
        self.maxId = maxId
        
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if sinceId != nil {
            completion(.success([]))
            return
        } else if let maxId = maxId {
            guard let itemIndex = items.firstIndex(where: { AnyHashable($0.id) == AnyHashable(maxId) }) else {
                return
            }
            completion(.success(getMockItems(from: itemIndex)))
            return
        }
        
        completion(.success(getMockItems(from: items.startIndex)))
    }
    
    private func getMockItems(from index: Int) -> MockItems {
        let distance = items.distance(from: index, to: items.endIndex)
        if distance <= 1 {
            return []
        }
        
        let endIndex = index.advanced(by: distance < 10 ? distance.advanced(by: -1) : 10)
        let range = index.advanced(by: 1) ... endIndex
        return Array(items[range.lowerBound...range.upperBound])
    }
}
