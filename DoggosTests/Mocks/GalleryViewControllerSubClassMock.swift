//
//  GalleryViewControllerSubClassMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class GalleryViewControllerSubClassMock: GalleryViewController {
    var didCallDismiss = false
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        didCallDismiss = true
    }
}
