//
//  ListPresenterTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class ListPresenterTest: XCTestCase {
    
    var view: ListViewControllerMock?
    var presenter: ListPresenter?
    var datasource: DatasourceMock?
    var router: ListRouterMock?
    
    override func setUp() {
        super.setUp()
        view = ListViewControllerMock()
        datasource = DatasourceMock()
        router = ListRouterMock(view: ListViewController())
        presenter = ListPresenter(view: view!, repo: datasource!, router: router!)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        datasource = nil
        router = nil
        super.tearDown()
    }
    
    func testPresenterDidCallViewDisplayList() {
        presenter?.view.displayDoggosList(doggos: [])
        XCTAssert(view!.displayListWasCalled)
    }
    
    func testPresenterDidCallViewDisplayError() {
        presenter?.view.displayErrorView(withMessage: "")
        XCTAssert(view!.displayErrorWasCalled)
    }
    
    func testPresenterDidCallGoToGallery() {
        presenter?.doggos = [Doggo(name: "foo", photos: [])]
        presenter?.goToGallery(forDoggoInIndex: 0)
        XCTAssert(router!.didCallGoToGallery)
    }
    
    func testPresenterDidCallDatasourceListDogs() {
        presenter?.getDoggosList()
        XCTAssertTrue(datasource!.didCallDogList)
    }
    
    func testPresenterCallViewDisplayListOnSuccessCallbackFromRepoWithValidData() {
        datasource?.callOnSuccessWithValidData()
        XCTAssertTrue(view!.displayListWasCalled)
    }
    
    func testPresenterCallViewDisplayErrorOnSucessCallbackFromRepoWithInvalidData() {
        datasource?.callOnSuccessWithInvalidData()
        XCTAssertTrue(view!.displayErrorWasCalled)
        XCTAssertEqual(view?.errorMessage, "We couldn't get the data in this moment. It seems all dogos are in the park.")
    }
    
    func testPresenterCallViewDisplayErrorOnFailCallBackFromRepo() {
        datasource?.callOnFail()
        XCTAssertTrue(view!.displayErrorWasCalled)
        XCTAssertNotEqual(view?.errorMessage, "We couldn't get the data in this moment. It seems all dogos are in the park.")
    }
    
    func testPresenterDidCallRouterGoToGallery() {
        presenter?.router.goToGallery(withDoggo: Doggo(name: "foo", photos: []))
        XCTAssertTrue(router!.didCallGoToGallery)
    }
    
 
}
