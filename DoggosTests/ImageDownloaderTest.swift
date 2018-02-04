//
//  ImageDownloaderTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class ImageDownloaderTest: XCTestCase {
    var imageDownloader: ImageDownloader?
    var imageDownloderDelegate: ImageDownloaderDelegateMock?
    override func setUp() {
        super.setUp()
        imageDownloader = ImageDownloader()
        imageDownloderDelegate = ImageDownloaderDelegateMock()
        imageDownloader?.delegate = imageDownloderDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        imageDownloderDelegate = nil
        imageDownloader = nil
    }
    
    func testStartShouldSetIsRunningToTrue() {
        imageDownloader?.start()
        XCTAssertTrue(imageDownloader!.isRunning)
    }
    
    func testStipShouldSetIsRunningToFalse() {
        imageDownloader?.stop()
        XCTAssertFalse(imageDownloader!.isRunning)
    }
    
    func testCallDidGetDataShouldCallDelegateDidGetData() {
        imageDownloader?.delegate?.didGetData(data: Data(), atIndex: 0)
        XCTAssertTrue(imageDownloderDelegate!.didCallGetData)
    }
    
    func testCallErrorOnDowloadShouldCallDelegateErrorOnDowload() {
        imageDownloader?.delegate?.errorOnDowload(error: "some")
        XCTAssertTrue(imageDownloderDelegate!.didCallErrorOnDownload)
    }
}
