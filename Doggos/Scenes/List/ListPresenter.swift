//
//  ListPresenter.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

protocol ListPresenterProtocol: class {
    func getDoggosList()
    func goToGallery(forDoggoInIndex index: Int)
}
class ListPresenter {
    //MARK - Properties
    var view: ListViewControllerProtocol
    var repo: Datasource
    var router: ListRouterProtocol
    var doggos: [Doggo] = []
   
    //MARK - Lifecycle
    init(view: ListViewControllerProtocol, repo: Datasource, router: ListRouterProtocol) {
        self.view = view
        self.repo = repo
        self.router = router
        self.repo.delegate = self
    }
}
extension ListPresenter:ListPresenterProtocol {
    func getDoggosList() {
        repo.getDogsList()
    }
    
    func goToGallery(forDoggoInIndex index: Int) {
        router.goToGallery(withDoggo: doggos[index])
    }
}
extension ListPresenter: DatasourceDelegate {
    func onSuccess(response: DatasourceResult) {
        guard let doggoDTO = response.object as? DoggoDTO, let doggos = doggoDTO.getDoggos() else {
            view.displayErrorView(withMessage: "We couldn't get the data in this moment. It seems all dogos are in the park.")
            return
        }
        self.doggos = doggos
        view.displayDoggosList(doggos: DoggoViewModel.viewModelsFromObjects(objects: doggos))
    }
    
    func onFail(error: DatasourceError) {
        view.displayErrorView(withMessage: error.error)
    }
}
