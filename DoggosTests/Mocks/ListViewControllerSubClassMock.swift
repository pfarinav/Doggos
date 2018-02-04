//
//  ListViewControllerSubClassMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class ListViewControllerSubClassMock: ListViewController {
    var didCallPresent = false
    var isGalleryViewController = false
    
    override func viewDidLoad() {}
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        didCallPresent = true
        if let _ = viewControllerToPresent as? GalleryViewController {
            isGalleryViewController = true
        }
    }
}
