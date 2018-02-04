//
//  GalleryViewController.swift
//  Doggos
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import UIKit
protocol GalleryViewControllerProtocol:class {
    func displayErrorView(withMessage message: String)
    func displayDoggoGallery(withViewModel vm: DoggoViewModel)
    func setImageForCellAtIndex(_ index: Int, withData data: Data)
}
typealias GalleryItem = (url: URL, image: UIImage?)
class GalleryViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var breadLabel: UILabel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var photosAmountLabel: UILabel!
    
    //MARK: - Properties
    lazy var presenter: GalleryPresenterProtocol = {
        let repo = RestSource()
        let router = GalleryRouter(view: self)
        let presenter =  GalleryPresenter(view: self, repo: repo, router: router)
        let imageDownloader = ImageDownloader()
        presenter.imageDownloader = imageDownloader
        return presenter
    }()
    var photos: [GalleryItem] = []
    var loaded = 0
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: GalleryCollectionViewCell.nibName, bundle: nil)
        galleryCollectionView.register(nib, forCellWithReuseIdentifier: GalleryCollectionViewCell.identfier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getGallery()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.stopImagesDownload()
    }
    
    //MARK: - IBActions
    @IBAction func didPressCloseButton(_ sender: Any) {
        presenter.goBack()
    }
}

extension GalleryViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {    return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identfier, for: indexPath) as! GalleryCollectionViewCell
        cell.image = nil
        cell.pageNumber.text = "\(indexPath.row + 1)"
        if photos[indexPath.row].image != nil {
            cell.image = photos[indexPath.row].image!
        } else {
            presenter.getImageFor(url: photos[indexPath.row].url, atIndex: indexPath.row)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension GalleryViewController: GalleryViewControllerProtocol {
    func displayErrorView(withMessage message: String) {
        let errorView = ErrorView()
        let frame = CGRect(x: 0, y: breadLabel.frame.origin.y, width: view.frame.width, height: view.frame.height - breadLabel.frame.origin.y)
        errorView.frame = frame
        errorView.titleLabel.text = "Oh oh... we had a problem."
        errorView.descriptionLabel.text = message
        view.addSubview(errorView)
    }
    
    func displayDoggoGallery(withViewModel vm: DoggoViewModel) {
        breadLabel.text = vm.name
        photos = vm.photos.map({
            GalleryItem(url: $0, image: nil)
        })
        photosAmountLabel.text = "\(photos.count)\nPhotos"
        loadingLabel.text = "Loaded \(loaded)/\(photos.count)"
        galleryCollectionView.reloadData()
    }
    
    func setImageForCellAtIndex(_ index: Int, withData data: Data) {
        let indexPath = IndexPath(row: index, section: 0)
        photos[index].image = UIImage(data: data)
        galleryCollectionView.reloadItems(at: [indexPath])
        loaded += 1
        loadingLabel.text = "Loaded \(loaded)/\(photos.count)"
    }
}
