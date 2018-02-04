//
//  ListViewControllerTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class ListViewControllerTest: XCTestCase {
    var presenter: ListPresenterMock?
    var view: ListViewController?
    
    override func setUp() {
        super.setUp()
        presenter = ListPresenterMock()
        view = ListViewController()
        view?.presenter = presenter!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewCallPresenterListDogs() {
        view?.presenter.getDoggosList()
        XCTAssertTrue(presenter!.didCallDoggosList)
    }
    
    func testCallOfDisplayDoggosChangesDoggosProperty(){
        _ = view?.view
        let preCallAmount = view?.doggos.count
        XCTAssertTrue(preCallAmount! == 0)
        let vm = DoggoViewModel(name: "foo", photos: [])
        view?.displayDoggosList(doggos: [vm])
        let postCallAmount = view?.doggos.count
        XCTAssertTrue(postCallAmount! == 1)
        XCTAssertEqual(view?.doggos[0].name, vm.name)
    }
    
    func testCallOfDisplayErrorGenerateErrorViewWithCustomMessage(){
        _ = view?.view
        let message = "Test"
        view?.displayErrorView(withMessage: message)
        guard let lastView = view!.view.subviews[view!.view.subviews.count - 1] as? ErrorView else {
            XCTFail()
            return
        }
        XCTAssertEqual(lastView.descriptionLabel.text, message)
    }
    
    func testSpinnerShouldBeHiddenAfterCallingRecevingDogList() {
        _ = view?.view
        XCTAssertFalse(view!.spinner.isHidden)
        let vm = DoggoViewModel(name: "foo", photos: [])
        view?.displayDoggosList(doggos: [vm])
        XCTAssertTrue(view!.spinner.isHidden)
    }
    
    func testOnInitTableViewShouldExistsWithZeroElements() {
        _ = view?.view
        view?.doggosListTableView.reloadData()
        XCTAssertEqual(view!.doggosListTableView.numberOfRows(inSection: 0), 0)
    }
    
    func testWhenListHaveElementsHeightShouldBeDoggoTableViewCellHeight() {
        _ = view?.view
        view?.doggos.append(DoggoViewModel(name: "foo", photos: []))
        view?.doggosListTableView.reloadData()
        XCTAssertEqual(view!.doggosListTableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(view!.tableView(view!.doggosListTableView, heightForRowAt: IndexPath(row: 0, section: 0)), DoggoTableViewCell.cellHeight)
    }
    
    func testWhenTapOnCellCallPresenterGoToGallery() {
        _ = view?.view
        view?.doggos.append(DoggoViewModel(name: "foo", photos: []))
        view?.doggosListTableView.reloadData()
        XCTAssertEqual(view!.doggosListTableView.numberOfRows(inSection: 0), 1)
        view?.tableView(view!.doggosListTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(presenter!.didCallGoToGallery)
    }
    
    func testCellForRowWithValidIndexPathReturnsDoggoTableViewCell() {
        _ = view?.view
        view?.doggos.append(DoggoViewModel(name: "foo", photos: []))
        view?.doggosListTableView.reloadData()
        guard let _ = view?.tableView(view!.doggosListTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DoggoTableViewCell else {
            XCTFail()
            return
        }
        XCTAssertTrue(true)
    }
}
