//
//  GalleryRouter.swift
//  Doggos
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

protocol GalleryRouterProtocol: class {
    var view: GalleryViewController {get set}
    func goBack()
}
class GalleryRouter: GalleryRouterProtocol {
    var view: GalleryViewController
    
    init(view: GalleryViewController) {
        self.view = view
    }
    
    func goBack() {
        view.dismiss(animated: true, completion: nil)
    }
    
    
}
