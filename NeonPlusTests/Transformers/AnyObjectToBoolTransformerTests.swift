//
//  AnyObjectToBoolTransformerTests.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 03/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import XCTest
@testable import NeonPlus

class AnyObjectToBoolTransformerTests: XCTestCase {

    var transformer: AnyObjectToBoolTransformer?

    override func setUp() {
        super.setUp()
        self.transformer = AnyObjectToBoolTransformer()
    }

    func testTransformMustReturnTrue() {
        XCTAssertNotNil(self.transformer, "Transformer should have be initialized at this point.")
        XCTAssertTrue(self.transformer!.transform("true") ?? false, "Should have returned true.")
    }

    func testTransformMustReturnFalse() {
        XCTAssertNotNil(self.transformer, "Transformer should have be initialized at this point.")
        XCTAssertFalse(self.transformer!.transform("false") ?? true, "Should have returned false.")
    }

}
