//
//  HttpClient.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 10/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

public typealias HttpCompletionBlock = (HttpResponse) -> Void

public protocol HttpClient {
    
    func get(_ urlString: String,
             options: HttpOptions,
             completion: @escaping HttpCompletionBlock)
    
    func post(_ urlString: String,
              data: Data?,
              options: HttpOptions,
              completion: @escaping HttpCompletionBlock)
    
    func delete(_ urlString: String,
                data: Data?,
                options: HttpOptions,
                completion: @escaping HttpCompletionBlock)
    
    func put(_ urlString: String,
             data: Data?,
             options: HttpOptions,
             completion: @escaping HttpCompletionBlock)
}

public extension HttpClient {
    
    func get(_ urlString: String,
             completion: @escaping HttpCompletionBlock) {
        get(urlString,
            options: HttpOptions(),
            completion: completion)
    }
    
    func post(_ urlString: String,
              data: Data? = nil,
              completion: @escaping HttpCompletionBlock) {
        post(urlString,
             data: data,
             options: HttpOptions(),
             completion: completion)
    }
    
    func delete(_ urlString: String,
                data: Data? = nil,
                completion: @escaping HttpCompletionBlock) {
        delete(urlString,
               data: data,
               options: HttpOptions(),
               completion: completion)
    }
    
    func put(_ urlString: String,
             data: Data? = nil,
             completion: @escaping HttpCompletionBlock) {
        put(urlString,
            data: data,
            options: HttpOptions(),
            completion: completion)
    }
}
