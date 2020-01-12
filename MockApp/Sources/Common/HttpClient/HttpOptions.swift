//
//  HttpOptions.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 11/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

public typealias HttpHeaders = [String: String]

public struct HttpOptions {
    public var headers: HttpHeaders
    
    public init(headers: HttpHeaders = HttpHeaders()) {
        self.headers = headers
    }
}
