//
//  MockItemList.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 12/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

final class MockItemList: ObservableObject {
    
    @Published private(set) var items: MockItems
    @Published private(set) var error: Error?
    
    @Published private(set) var isLoading: Bool = false
    
    private let mockItemService: MockItemService
    
    init(mockItemService: MockItemService) {
        self.mockItemService = mockItemService
        
        items = []
    }
    
    func loadItems() {
        guard !isLoading else {
            return
        }
        
        self.error = nil
        isLoading = true
        mockItemService.fetchMockItems { [weak self] result in
            DispatchQueue.main.async {
                self?.handleInitialResult(result)
                self?.isLoading = false
            }
        }
    }
    
    private func handleInitialResult(_ result: Result<MockItems, Error>) {
        switch result {
        case .success(let items):
            self.items = items
        case .failure(let error):
            self.error = error
        }
    }
}
