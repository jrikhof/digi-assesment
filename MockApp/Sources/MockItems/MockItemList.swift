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
    
    // MARK: - Load Items
    
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
    
    // MARK: - Item Appears
    
    func itemAppears(_ item: MockItem) {
        if items.isLastItem(item) {
            loadNextItems(maxId: item.id)
        }
    }
    
    // MARK: - Load Next Items
    
    private func loadNextItems(maxId: String) {
        guard !isLoading else {
            return
        }
        
        self.error = nil
        isLoading = true
        mockItemService.fetchMockItems(maxId: maxId) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleNextResult(result)
                self?.isLoading = false
            }
        }
    }
    
    private func handleNextResult(_ result: Result<MockItems, Error>) {
        switch result {
        case .success(let items):
            self.items.append(contentsOf: items)
        case .failure(let error):
            self.error = error
        }
    }
}
