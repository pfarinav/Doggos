//
//  ImageDownloaderMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class ImageDownloaderMock: ImageDownloaderProtocol {
    var delegate: ImageDownloaderDelegate?
    
    var isRunning: Bool
    init() {
        isRunning = false
    }
    
    var didCallAddUrl = false
    func addUrl(url: URL, atIndex index: Int) {
        didCallAddUrl = true
    }
  
    var didCallStart = false
    func start() {
        didCallStart = true
    }
  
    var didCallStop = false
    func stop() {
        didCallStop = true
    }
    
    func callDidGetData()
    {
        let data = Data()
        delegate?.didGetData(data: data, atIndex: 0)
    }
    
    func callErrorOnDowload() {
        delegate?.errorOnDowload(error: "error")
    }
    
}
