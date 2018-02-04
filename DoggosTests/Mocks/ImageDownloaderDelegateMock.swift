//
//  ImageDownloaderDelegateMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class ImageDownloaderDelegateMock: ImageDownloaderDelegate {
    var didCallGetData = false
    func didGetData(data: Data, atIndex index: Int) {
        didCallGetData = true
    }
    
    var didCallErrorOnDownload = false
    func errorOnDowload(error: String) {
        didCallErrorOnDownload = true
    }
    

}
