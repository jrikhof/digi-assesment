//
//  MockItemStorage.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 12/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

protocol MockItemStorage {
    
    func loadItems() -> MockItems
    func store(items: MockItems)
    
    func clear()
}

final class DefaultMockItemStorage: MockItemStorage {
    
    func loadItems() -> MockItems {
        do {
            let data = try Data(contentsOf: getFileUrl())
            let items = try JSONDecoder().decode(MockItems.self, from: data)
            return items
        } catch {
            return []
        }
    }
    
    func store(items: MockItems) {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: getFileUrl(), options: .atomic)
        } catch {
            print(error)
        }
    }
    
    func clear() {
        let path = getFileUrl().absoluteString
        if FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.removeItem(atPath: path)
        }
    }
    
    private func getFileUrl() -> URL {
        return getDocumentsDirectory().appendingPathComponent("mockitems.dat")
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
