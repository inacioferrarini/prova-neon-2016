//
//  AnyObjectToUserTokenTransformerTests.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 03/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import XCTest
@testable import NeonPlus

class AnyObjectToUserTokenTransformerTests: XCTestCase {

    var transformer: AnyObjectToUserTokenTransformer?

    override func setUp() {
        super.setUp()
        self.transformer = AnyObjectToUserTokenTransformer()
    }

    func testTransform() {
        XCTAssertNotNil(self.transformer, "Transformer should have be initialized at this point.")
        let tokenValue = NSUUID().UUIDString
        let parsedToken = self.transformer!.transform(tokenValue)
        XCTAssertNotNil(parsedToken, "Token should have be parsed at this point.")
        XCTAssertNotNil(parsedToken!.token, "Token value should have be parsed at this point.")
        XCTAssertEqual(tokenValue, parsedToken!.token, "Provided token value and parsed token value should be the same.")
    }

}
