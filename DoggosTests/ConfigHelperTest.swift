//
//  ConfigHelperTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos
class ConfigHelperTest: XCTestCase {
    func testConfigHelperShouldReturnValidStringWhenKeyIsValid() {
        let value = ConfigHelper.get(valueForKey: "RSBaseUrl")
        XCTAssertNotNil(value)
        guard let _ = value as? String else {
            XCTFail()
            return
        }
        XCTAssertTrue(true)
    }
    func testConfigHelperShouldReturnNilWhenKeyIsInvalid() {
        let value = ConfigHelper.get(valueForKey: "PepePateatraseros")
        XCTAssertNil(value)
    }
}
