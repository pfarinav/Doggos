//
//  ListRouterTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class ListRouterTest: XCTestCase {
    var router: ListRouter?
    var view: ListViewControllerSubClassMock?
    
    override func setUp() {
        super.setUp()
        view = ListViewControllerSubClassMock()
        router = ListRouter(view: view!)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        router = nil
    }
    
    func testGoToGalleryShouldPresentGalleryViewController() {
        _ = view?.view
        router?.goToGallery(withDoggo: Doggo(name: "foo", photos: []))
        XCTAssertTrue(view!.didCallPresent)
        XCTAssertTrue(view!.isGalleryViewController)
    }
}
