//
//  GalleryRouterTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class GalleryRouterTest: XCTestCase {
    var router: GalleryRouter?
    var view: GalleryViewControllerSubClassMock?
    
    override func setUp() {
        super.setUp()
        view = GalleryViewControllerSubClassMock()
        router = GalleryRouter(view: view!)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        router = nil
    }
    
    func testGoBackShouldDismissView() {
        router?.goBack()
        XCTAssertTrue(view!.didCallDismiss)
    }
}
