//
//  GalleryPresenterMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class GalleryPresenterMock: GalleryPresenterProtocol {
    var doggo: Doggo?
    
    var imageDownloader: ImageDownloaderProtocol?
    var didCallGetGallery = false
    func getGallery() {
        didCallGetGallery = true
    }
    var didCallGoBack = false
    func goBack() {
        didCallGoBack = true
    }
    var didCallStopImagesDownload = false
    func stopImagesDownload() {
        didCallStopImagesDownload = true
    }
    var didCallGetImagesFor = false
    func getImageFor(url: URL, atIndex index: Int) {
        didCallGetImagesFor = true
    }
    
    
}
