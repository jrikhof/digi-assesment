//
//  NetworkSession.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 10/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

public protocol NetworkSession {
    
    func loadData(from request: URLRequest,
                  completionHandler: @escaping HttpCompletionBlock)   
}

extension URLSession: NetworkSession {
    
    public func loadData(from request: URLRequest,
                         completionHandler: @escaping HttpCompletionBlock) {
        dataTask(with: request) { data, response, error in
            if let error = error {
                return completionHandler(HttpResponse(data: data, error: error))
            }
            if let httpResponse = response as? HTTPURLResponse {
                completionHandler(HttpResponse(data: data,
                                               headers: httpResponse.allHeaderFields))
            } else {
                completionHandler(HttpResponse(data: data))
            }
        }.resume()
    }
}
