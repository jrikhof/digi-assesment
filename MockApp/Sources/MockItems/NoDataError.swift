//
//  NoDataError.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 12/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

struct NoDataError: LocalizedError {
    
    var errorDescription: String? {
        return "No data received."
    }
}
