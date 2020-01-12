//
//  NetworkSessionHTTPClient.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 10/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

public final class NetworkSessionHTTPClient: HttpClient {
    
    private let networkSession: NetworkSession
    
    public init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    public func get(_ urlString: String,
                    options: HttpOptions,
                    completion: @escaping HttpCompletionBlock) {
        let request = self.request("GET", urlString: urlString, options: options)
        loadData(from: request, completion: completion)
    }
    
    public func post(_ urlString: String,
                     data: Data?,
                     options: HttpOptions,
                     completion: @escaping HttpCompletionBlock) {
        let request = self.request("POST", urlString: urlString, data: data, options: options)
        loadData(from: request, completion: completion)
    }
    
    public func delete(_ urlString: String,
                       data: Data?,
                       options: HttpOptions,
                       completion: @escaping HttpCompletionBlock) {
        let request = self.request("DELETE", urlString: urlString, data: data, options: options)
        loadData(from: request, completion: completion)
    }
    
    public func put(_ urlString: String,
                    data: Data?,
                    options: HttpOptions,
                    completion: @escaping HttpCompletionBlock) {
        let request = self.request("PUT", urlString: urlString, data: data, options: options)
        loadData(from: request, completion: completion)
    }
    
    private func request(_ method: String,
                         urlString: String,
                         data: Data? = nil,
                         options: HttpOptions) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        addData(data, to: &request)
        addHeaders(options.headers, to: &request)
        
        return request
    }

    private func loadData(from request: URLRequest?,
                          completion: @escaping HttpCompletionBlock) {
        guard let request = request else {
            return completion(HttpResponse(error: InvalidRequestError()))
        }
        networkSession.loadData(from: request,
                                completionHandler: completion)
    }
    
    private func addHeaders(_ headers: HttpHeaders, to request: inout URLRequest) {
        headers.forEach { (arg) in
            let (key, value) = arg
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func addData(_ data: Data?, to request: inout URLRequest) {
        guard let data = data else {
            return
        }
        
        request.httpBody = data
        request.setValue(data.count.description, forHTTPHeaderField: HttpHeaderKey.contentLength)
    }
}
