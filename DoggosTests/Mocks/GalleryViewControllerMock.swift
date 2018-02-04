//
//  GalleryViewControllerMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class GalleryViewControllerMock: GalleryViewControllerProtocol {
    var error = ""
    var didCallDisplayErrorView = false
    func displayErrorView(withMessage message: String) {
        didCallDisplayErrorView = true
        error = message
    }
    var didCallDisplayDoggoGallery = false
    func displayDoggoGallery(withViewModel vm: DoggoViewModel) {
        didCallDisplayDoggoGallery = true
    }
    var didCallsetImageForCellAtIndex = false
    func setImageForCellAtIndex(_ index: Int, withData data: Data) {
        didCallsetImageForCellAtIndex = true
    }
    

}
