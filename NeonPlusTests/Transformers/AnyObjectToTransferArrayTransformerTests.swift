//
//  AnyObjectToTransferArrayTransformerTests.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 03/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import XCTest
@testable import NeonPlus

class AnyObjectToTransferArrayTransformerTests: XCTestCase {

    var transformer: AnyObjectToTransferArrayTransformer?
    let dateFormatter = NSDateFormatter()
    let tokenValue = NSUUID().UUIDString

    override func setUp() {
        super.setUp()
        self.transformer = AnyObjectToTransferArrayTransformer()
        self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
    }

    func createTestData() -> [[String : AnyObject]] {
        var dic = [[String : AnyObject]]()
        dic.append(["Id" : "0",
            "ClienteId" : "0",
            "Valor" : "100.00",
            "Token" : self.tokenValue,
            "Data" : "2016-10-02T19:12:30.00"])
        dic.append(["Id" : "1",
            "ClienteId" : "1",
            "Valor" : "200.00",
            "Token" : self.tokenValue,
            "Data" : "2016-10-02T18:12:30.00"])
        dic.append(["Id" : "2",
            "ClienteId" : "2",
            "Valor" : "150.00",
            "Token" : self.tokenValue,
            "Data" : "2016-09-02T21:12:30.00"])
        dic.append(["Id" : "3",
            "ClienteId" : "3",
            "Valor" : "50.00",
            "Token" : self.tokenValue,
            "Data" : "2016-09-02T21:10:35.37"])
        return dic
    }

    func testTransform() {
        XCTAssertNotNil(self.transformer, "Transformer should have be initialized at this point.")
        let data = self.createTestData()
        let parsedTransferArray = self.transformer!.transform(data)
        XCTAssertNotNil(parsedTransferArray, "Transfer Array should have be parsed at this point.")
    }

    func testEachTransformedValues() {
        XCTAssertNotNil(self.transformer, "Transformer should have be initialized at this point.")
        let data = self.createTestData()
        let parsedTransferArray = self.transformer!.transform(data)
        XCTAssertTrue(parsedTransferArray.count == 4, "Transfer Array should have 4 elements.")
        
        let item1 = parsedTransferArray[0]
        XCTAssertEqual(item1.uid!.integerValue, NSNumber(integer: Int(0)), "Expected value does not match.")
        XCTAssertEqual(item1.clientUid!.integerValue, NSNumber(integer: Int(0)), "Expected value does not match.")
        XCTAssertEqual(item1.value!.doubleValue, NSNumber(double: 100.00), "Expected value does not match.")
        XCTAssertEqual(item1.token!, self.tokenValue, "Expected value does not match.")
        let parsedData = self.dateFormatter.stringFromDate(item1.date ?? NSDate())
        XCTAssertEqual(parsedData, "2016-10-02T19:12:30.00", "Expected value does not match.")

        let item2 = parsedTransferArray[1]
        XCTAssertEqual(item2.uid!.integerValue, NSNumber(integer: Int(1)), "Expected value does not match.")
        XCTAssertEqual(item2.clientUid!.integerValue, NSNumber(integer: Int(1)), "Expected value does not match.")
        XCTAssertEqual(item2.value!.doubleValue, NSNumber(double: 200.00), "Expected value does not match.")
        XCTAssertEqual(item2.token!, self.tokenValue, "Expected value does not match.")
        let parsedData2 = self.dateFormatter.stringFromDate(item2.date ?? NSDate())
        XCTAssertEqual(parsedData2, "2016-10-02T18:12:30.00", "Expected value does not match.")
        
        let item3 = parsedTransferArray[2]
        XCTAssertEqual(item3.uid!.integerValue, NSNumber(integer: Int(2)), "Expected value does not match.")
        XCTAssertEqual(item3.clientUid!.integerValue, NSNumber(integer: Int(2)), "Expected value does not match.")
        XCTAssertEqual(item3.value!.doubleValue, NSNumber(double: 150.00), "Expected value does not match.")
        XCTAssertEqual(item3.token!, self.tokenValue, "Expected value does not match.")
        let parsedData3 = self.dateFormatter.stringFromDate(item3.date ?? NSDate())
        XCTAssertEqual(parsedData3, "2016-09-02T21:12:30.00", "Expected value does not match.")

        let item4 = parsedTransferArray[3]
        XCTAssertEqual(item4.uid!.integerValue, NSNumber(integer: Int(3)), "Expected value does not match.")
        XCTAssertEqual(item4.clientUid!.integerValue, NSNumber(integer: Int(3)), "Expected value does not match.")
        XCTAssertEqual(item4.value!.doubleValue, NSNumber(double: 50.00), "Expected value does not match.")
        XCTAssertEqual(item4.token!, self.tokenValue, "Expected value does not match.")
        let parsedData4 = self.dateFormatter.stringFromDate(item4.date ?? NSDate())
        XCTAssertEqual(parsedData4, "2016-09-02T21:10:35.37", "Expected value does not match.")
    }

}
