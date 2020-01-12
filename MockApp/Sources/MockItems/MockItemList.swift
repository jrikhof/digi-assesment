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
    
    private let mockItemStorage: MockItemStorage
    private let mockItemService: MockItemService
    private var isInitialLoad: Bool = true
    
    init(mockItemStorage: MockItemStorage, mockItemService: MockItemService) {
        self.mockItemStorage = mockItemStorage
        self.mockItemService = mockItemService
        
        items = []
    }
    
    // MARK: - Load Items
    
    func loadItems() {
        items = mockItemStorage.loadItems()
        
        if items.isEmpty {
            loadOnlineItems()
        }
    }
    
    private func loadOnlineItems() {
        error = nil
        mockItemService.fetchMockItems { [weak self] result in
            DispatchQueue.main.async {
                self?.handleInitialResult(result)
            }
        }
    }
    
    private func handleInitialResult(_ result: Result<MockItems, Error>) {
        switch result {
        case .success(let items):
            self.items = items
            mockItemStorage.store(items: items)
        case .failure(let error):
            self.error = error
        }
    }
    
    // MARK: - Item Appears
    
    func itemAppears(_ item: MockItem) {
        if items.isFirstItem(item) {
            loadNewItems(sinceId: item.id)
        }
        if items.isLastItem(item) {
            loadNextItems(maxId: item.id)
        }
    }
    
    // MARK: - Load Next Items
    
    private func loadNextItems(maxId: String) {
        self.error = nil
        mockItemService.fetchMockItems(maxId: maxId) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleNextResult(result)
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
    
    // MARK: - Load new Items
    
    private func loadNewItems(sinceId: String) {
        guard !isLoading && !isInitialLoad else {
            // We need to prevent new items is fetched on initial load
            isInitialLoad = false
            return
        }
        
        error = nil
        isLoading = true
        mockItemService.fetchMockItems(sinceId: sinceId) { [weak self] result in
            // Add a little delay so the loading indicator is visible
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.handleNewResult(result)
                self?.isLoading = false
            }
        }
    }
    
    private func handleNewResult(_ result: Result<MockItems, Error>) {
        switch result {
        case .success(let items):
            self.items.insert(contentsOf: items, at: 0)
        case .failure(let error):
            self.error = error
        }
    }
}
