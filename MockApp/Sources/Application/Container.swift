//
//  Container.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 12/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

extension MockItemList {
    
    // For simplicity we leave out dependency injection
    
    class func resolve() -> MockItemList {
        
        let session = URLSession(
                configuration: URLSessionConfiguration.ephemeral,
                delegate: PinningDelegate(),
                delegateQueue: nil)
        
        let httpClient = NetworkSessionHTTPClient(networkSession: session)
        let service = HttpMockItemService(httpClient: httpClient)
        return MockItemList(mockItemStorage: DefaultMockItemStorage(),
                            mockItemService: service)
    }
}
