//
//  HttpMockItemService.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 12/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

class HttpMockItemService: MockItemService {
    
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchMockItems(sinceId: String?, maxId: String?, completion: @escaping (Result<MockItems, Error>) -> Void) {
        httpClient.get(getUrl(sinceId: sinceId, maxId: maxId),
                       options: defaultHttpOptions()) { response in
                        if let error = response.error {
                            return completion(.failure(error))
                        }
                        
                        guard let data = response.data else {
                            return completion(.failure(NoDataError()))
                        }
                        
                        do {
                            let mockItems = try JSONDecoder().decode(MockItems.self, from: data)
                            completion(.success(mockItems))
                        } catch {
                            completion(.failure(error))
                        }
        }
    }
    
    private func defaultHttpOptions() -> HttpOptions {
        guard !Config.Authorization.token.isEmpty else {
            fatalError("Empty Authorization token. Please provide a valid token in the Config file.")
        }
        
        return HttpOptions(headers: [HttpHeaderKey.authorization: Config.Authorization.token])
    }
    
    private func getUrl(sinceId: String? = nil, maxId: String? = nil) -> String {
        guard !Config.baseUrl.isEmpty else {
            fatalError("Incorrect BaseUrl. Please provide a valid baseUrl in the Config file.")
        }
        
        var urlComps = URLComponents(string: Config.baseUrl)
        urlComps?.path = "/e/mock/v1/items"
        
        if let sinceId = sinceId {
            urlComps?.queryItems = [URLQueryItem(name: "since_id", value: sinceId)]
        } else if let maxId = maxId {
            urlComps?.queryItems = [URLQueryItem(name: "max_id", value: maxId)]
        }
        
        guard let urlString = urlComps?.url?.absoluteString else {
            fatalError("Could not get valid Url.")
        }
            
        return urlString
    }
}
