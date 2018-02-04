//
//  GalleryRouterMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class GalleryRouterMock: GalleryRouterProtocol {
    var view: GalleryViewController
    init() {
        self.view = GalleryViewController()
    }
    var didCallGoBack = false
    func goBack() {
        didCallGoBack = true
    }
    

}
