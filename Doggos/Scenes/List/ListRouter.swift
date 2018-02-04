//
//  ListRouter.swift
//  Doggos
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

protocol ListRouterProtocol: class {
    var view: ListViewController{ get set }
    func goToGallery(withDoggo doggo: Doggo)
}
class ListRouter: ListRouterProtocol {
    //MARK - Properties
    var view: ListViewController
    
    //MARK - Lifecycles
    init(view: ListViewController) {
        self.view = view
    }
    
    //MARK - Methods
    func goToGallery(withDoggo doggo: Doggo) {
        let newViewController = GalleryViewController()
        let presenter = newViewController.presenter
        presenter.doggo = doggo
        view.present(newViewController, animated: true, completion: nil)
    }
}
