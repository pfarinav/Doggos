//
//  ListPresenterMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class ListPresenterMock: ListPresenterProtocol {
    var didCallGoToGallery = false
    func goToGallery(forDoggoInIndex index: Int) {
        didCallGoToGallery = true
    }
    
    var didCallDoggosList = false
    func getDoggosList() {
        didCallDoggosList = true
    }

}
