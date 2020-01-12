//
//  InvalidRequestError.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 11/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

public struct InvalidRequestError: LocalizedError {
    
    public var errorDescription: String? {
        return "Invalid request"
    }
}
