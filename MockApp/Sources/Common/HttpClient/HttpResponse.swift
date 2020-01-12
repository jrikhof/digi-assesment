//
//  HttpResponse.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 11/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

public struct HttpResponse {
    public let data: Data?
    public let headers: [AnyHashable: Any]
    public let error: Error?
    
    public init(data: Data? = nil,
                headers: [AnyHashable: Any] = [:],
                error: Error? = nil) {
        self.data = data
        self.headers = headers
        self.error = error
    }
}
