//
//  TransferToDictionaryTransformerTests.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 03/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import XCTest
@testable import NeonPlus

class TransferToDictionaryTransformerTests: XCTestCase {

    var transformer: TransferToDictionaryTransformer?
    let dateFormatter = NSDateFormatter()
    let tokenValue = NSUUID().UUIDString

    override func setUp() {
        super.setUp()
        self.transformer = TransferToDictionaryTransformer()
        self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
    }

    func testTransform() {
        XCTAssertNotNil(self.transformer, "Transformer should have be initialized at this point.")

        let value = Transfer()
        value.uid = 20
        value.clientUid = 30
        value.value = 500
        value.token = self.tokenValue
        value.date = self.dateFormatter.dateFromString("2017-08-01T19:12:30.00")

        let transformedValue = self.transformer!.transform(value)
        XCTAssertEqual(transformedValue["Id"]!.integerValue, NSNumber(integer: Int(20)), "Expected value does not match.")
        XCTAssertEqual(transformedValue["ClienteId"]!.integerValue, NSNumber(integer: Int(30)), "Expected value does not match.")
        XCTAssertEqual(transformedValue["Valor"]!.doubleValue, NSNumber(double: 500), "Expected value does not match.")
        XCTAssertEqual(transformedValue["Token"]! as? String, self.tokenValue, "Expected value does not match.")
        XCTAssertEqual(transformedValue["Data"]! as? String, "2017-08-01T19:12:30.00", "Expected value does not match.")
    }

}
