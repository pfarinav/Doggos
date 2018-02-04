//
//  ListRouterMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class ListRouterMock: ListRouterProtocol {
    var view: ListViewController
    init(view: ListViewController){
        self.view = view
    }
    var didCallGoToGallery = false
    func goToGallery(withDoggo doggo: Doggo) {
        didCallGoToGallery = true
    }
    

}
