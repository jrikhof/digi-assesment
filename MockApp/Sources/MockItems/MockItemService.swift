//
//  MockItemService.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 11/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

protocol MockItemService {
    func fetchMockItems(sinceId: String?, maxId: String?, completion: @escaping (Result<MockItems, Error>) -> Void)
}

extension MockItemService {
    
    func fetchMockItems(completion: @escaping (Result<MockItems, Error>) -> Void) {
        fetchMockItems(sinceId: nil, maxId: nil, completion: completion)
    }
    
    func fetchMockItems(sinceId: String?, completion: @escaping (Result<MockItems, Error>) -> Void) {
        fetchMockItems(sinceId: sinceId, maxId: nil, completion: completion)
    }
    
    func fetchMockItems(maxId: String?, completion: @escaping (Result<MockItems, Error>) -> Void) {
        fetchMockItems(sinceId: nil, maxId: maxId, completion: completion)
    }
}
