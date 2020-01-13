//
//  MockItem.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 10/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import Foundation

typealias MockItems = [MockItem]

struct MockItem: Identifiable {

    var id: String
    var text: String
    var confidence: Double
    var img: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case confidence
        case img
    }
    
    var imageData: Data? {
        let data = Data(base64Encoded: img, options: .ignoreUnknownCharacters)
        return data
    }
}

extension MockItem: Codable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
        confidence = try values.decode(Double.self, forKey: .confidence)
        img = try values.decode(String.self, forKey: .img)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(img, forKey: .img)
    }
}
