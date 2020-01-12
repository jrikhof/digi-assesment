//
//  MockItemTests.swift
//  MockAppTests
//
//  Created by Jeroen Rikhof on 10/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import XCTest
@testable import MockApp

class MockItemTests: XCTestCase {

    var mockItems: MockItems!

    override func setUp() {
        super.setUp()
        
        guard let data = MockData.json.data(using: .utf8) else {
            return
        }
        do {
            mockItems = try JSONDecoder().decode(MockItems.self, from: data)
        } catch {
            
        }
    }
    
    func testMockItemCanDecodeId() {
        XCTAssertEqual(mockItems[0].id, "5d9604e59bce4")
    }
    
    func testMockItemCanDecodeText() {
        XCTAssertEqual(mockItems[0].text, "30. pyshn")
    }
    
    func testMockItemCanDecodeConfidence() {
        XCTAssertEqual(mockItems[0].confidence, 0.55)
    }
    
    func testMockItemCanDecodeImg() {
        // swiftlint:disable:next line_length
        XCTAssertEqual(mockItems[0].img, "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V4zzMUt/HuoTy97655t+O1jjenziz0+V5vy2bu+9trVgHc+51pZqv31SlD4lhSlHBUW/HY/pXN+WeTC+n2BR9JvBWvsiNIwEi6LfDFbNTZwwDILFjE8Fa3oj59zfE4QSwaLoU8Fauy/tbH+2ijaCRdGngrV2T9pffh2J4xMsij55STgXK5eCrBEsij456T698bTrOiMrqggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcT4D1FPT2MrvjzCAAAAAElFTkSuQmCC")
    }
}
