//
//  ListViewControllerMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class ListViewControllerMock: ListViewControllerProtocol {
    var displayListWasCalled = false
    func displayDoggosList(doggos: [DoggoViewModel]) {
        displayListWasCalled = true
    }
    
    var displayErrorWasCalled = false
    var errorMessage = ""
    func displayErrorView(withMessage message: String) {
        displayErrorWasCalled = true
        errorMessage = message
    }
    
    
    
}
