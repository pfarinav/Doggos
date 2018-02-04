//
//  GalleryPresenter.swift
//  Doggos
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
protocol GalleryPresenterProtocol: class {
    var doggo: Doggo? { get set }
    var imageDownloader: ImageDownloaderProtocol? {get set}
    func getGallery()
    func goBack()
    func stopImagesDownload()
    func getImageFor(url: URL, atIndex index: Int)
}
class GalleryPresenter: GalleryPresenterProtocol {
    var view: GalleryViewControllerProtocol
    var repo: Datasource
    var router: GalleryRouterProtocol
    var doggo: Doggo?
    var imageDownloader: ImageDownloaderProtocol? {
        didSet {
            imageDownloader?.delegate = self
        }
    }
    
    init(view: GalleryViewControllerProtocol, repo: Datasource, router: GalleryRouterProtocol) {
        self.view = view
        self.repo = repo
        self.router = router
        self.repo.delegate = self
    }
    
    func getGallery() {
        guard let _doggo = doggo else {
            view.displayErrorView(withMessage: "This is embarrassing, but we don't know that kind of breed.")
            return
        }
        repo.getDogGallery(forBreed: _doggo.name)
    }
    
    func goBack() {
        router.goBack()
    }
    
    func stopImagesDownload() {
        imageDownloader?.stop()
    }
    
    func getImageFor(url: URL, atIndex index: Int) {
        imageDownloader?.addUrl(url: url, atIndex: index)
        if let _imageDownloader = imageDownloader, !_imageDownloader.isRunning {
            imageDownloader?.start()
        }
    }
}

extension GalleryPresenter: DatasourceDelegate {
    func onSuccess(response: DatasourceResult) {
        guard let doggoDTO = response.object as? DoggoDTO, let gallery = doggoDTO.getPhotos() as? [URL], gallery.count > 0 else {
            view.displayErrorView(withMessage: "We couldn't get the gallery, maybe it is a shy breed.")
            return
        }
        doggo!.photos = gallery
        view.displayDoggoGallery(withViewModel: DoggoViewModel.viewModelFromObject(object: doggo!))
    }
    
    func onFail(error: DatasourceError) {
        view.displayErrorView(withMessage: error.error)
    }
    
}

extension GalleryPresenter: ImageDownloaderDelegate {
    func didGetData(data: Data, atIndex index: Int) {
        view.setImageForCellAtIndex(index, withData: data)
    }
    
    func errorOnDowload(error: String) {
        view.displayErrorView(withMessage: error)
    }
    
    
}
