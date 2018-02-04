//
//  GalleryPresenterTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class GalleryPresenterTest: XCTestCase {
    
    var presenter: GalleryPresenter?
    var view: GalleryViewControllerMock?
    var datasource: DatasourceMock?
    var router: GalleryRouterMock?
    
    override func setUp() {
        super.setUp()
        view = GalleryViewControllerMock()
        datasource = DatasourceMock()
        router = GalleryRouterMock()
        presenter = GalleryPresenter(view: view!, repo: datasource!, router: router!)
    }
    
    override func tearDown() {
        view = nil
        datasource = nil
        router = nil
        presenter = nil
        super.tearDown()
    }
    
    func testPresenterWithoutDoggoWillNotCallGetGallery() {
        presenter?.getGallery()
        XCTAssertFalse(datasource!.didCallDogGallery)
    }
    
    func testPresenterWithDoggoWillCallGetGallery() {
        presenter!.doggo = Doggo(name: "foo", photos: [])
        presenter?.getGallery()
        XCTAssertTrue(datasource!.didCallDogGallery)
    }
    
    func testTryingToGetGalleryWithoutDogoWillDisplayErrorViewWithCustomMessage () {
        presenter?.getGallery()
        XCTAssertEqual(view?.error, "This is embarrassing, but we don't know that kind of breed.")
    }
    
    func testCallPresenterGoBackWillCallRouterGoBack() {
        presenter?.goBack()
        XCTAssertTrue(router!.didCallGoBack)
    }
    
    func testCallStopImagesDownloadWillCallStopOnImageDownloader() {
        let imageDownloader = ImageDownloaderMock()
        presenter?.imageDownloader = imageDownloader
        presenter?.stopImagesDownload()
        XCTAssertTrue(imageDownloader.didCallStop)
    }
    
    func testCallGetImageForWillCallStartAndAddUrlOnImageDownloader() {
        let imageDownloader = ImageDownloaderMock()
        presenter?.imageDownloader = imageDownloader
        presenter?.getImageFor(url: URL(string: "www.test.com")!, atIndex: 0)
        XCTAssertTrue(imageDownloader.didCallAddUrl)
        XCTAssertTrue(imageDownloader.didCallStart)
    }
    
    func testCallOnSuccessWithValidDataCallViewDisplayDoggoGallery() {
        presenter?.doggo = Doggo(name: "foo", photos: [])
        datasource?.callOnSuccessWithValidPhotosData()
        XCTAssertTrue(view!.didCallDisplayDoggoGallery)
    }
    
    func testCallOnSuccesWithValidDataAndEmptyListCallViewDisplayErrorWithCuatomMessage() {
        datasource?.callOnSuccessWithValidButEmptyPhotosData()
        XCTAssertTrue(view!.didCallDisplayErrorView)
        XCTAssertEqual(view?.error, "We couldn't get the gallery, maybe it is a shy breed.")
    }
    
    func testCallOnFailCallViewDisplayErrorWithErrorMessage(){
        datasource?.callOnFail()
        XCTAssertTrue(view!.didCallDisplayErrorView)
        XCTAssertEqual(view?.error, "error")
    }
    
    func testCallDidGetDataCallViewSetImageForCellAtIndex() {
        let imageDownloader = ImageDownloaderMock()
        presenter?.imageDownloader = imageDownloader
        imageDownloader.callDidGetData()
        XCTAssertTrue(view!.didCallsetImageForCellAtIndex)
    }
    
    func testCallErrorOnDownloadCallViewDisplayErrorWithErrorMessage(){
        let imageDownloader = ImageDownloaderMock()
        presenter?.imageDownloader = imageDownloader
        imageDownloader.callErrorOnDowload()
        XCTAssertTrue(view!.didCallDisplayErrorView)
        XCTAssertEqual(view?.error, "error")
    }
    
    
}
