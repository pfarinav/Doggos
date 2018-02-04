//
//  GalleryViewControllerTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class GalleryViewControllerTest: XCTestCase {
    var view: GalleryViewController?
    var presenter: GalleryPresenterMock?
    
    override func setUp() {
        super.setUp()
        view = GalleryViewController()
        presenter = GalleryPresenterMock()
        view!.presenter = presenter!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhenWillAppearCallPresenterGetGallery() {
        _ = view!.view
        view?.viewWillAppear(false)
        XCTAssertTrue(presenter!.didCallGetGallery)
    }
    
    func testWhenViewDidDissapearCallPresenterStopImagesDownload() {
        _ = view!.view
        view!.viewDidDisappear(false)
        XCTAssertTrue(presenter!.didCallStopImagesDownload)
    }
    
    func testDidPressCloseButtonCallPresenterGoBack() {
        _ = view!.view
        view!.didPressCloseButton(UIButton())
        XCTAssertTrue(presenter!.didCallGoBack)
    }
    
    func testCallOfDisplayErrorGenerateErrorViewWithCustomMessage(){
        _ = view?.view
        let message = "Test"
        view?.displayErrorView(withMessage: message)
        guard let lastView = view!.view.subviews[view!.view.subviews.count - 1] as? ErrorView else {
            XCTFail()
            return
        }
        XCTAssertEqual(lastView.descriptionLabel.text, message)
    }
    
    func testCellForItemCallPresenterGetImageForIfGalleryItemImageIsNil() {
        _ = view?.view
        let item = GalleryItem(url: URL(string: "www.test.com")!, image: nil)
        view!.photos.append(item)
        _ = view!.collectionView(view!.galleryCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(presenter!.didCallGetImagesFor)
    }
    
    func testCellForItemNotCallPresenterGetImageForIfGalleryItemImageIsNotNil() {
        _ = view?.view
        let item = GalleryItem(url: URL(string: "www.test.com")!, image: UIImage())
        view!.photos.append(item)
        _ = view!.collectionView(view!.galleryCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertFalse(presenter!.didCallGetImagesFor)
    }
    
    func testDisplayDoggoGalleryShouldChangeBreadLabelText() {
        _ = view?.view
        let preCallText = view!.breadLabel.text!
        view!.displayDoggoGallery(withViewModel: DoggoViewModel(name: "foo", photos: []))
        let postCallText = view!.breadLabel.text!
        XCTAssertNotEqual(preCallText, postCallText)
        XCTAssertEqual(postCallText, "foo")
    }
    
    func testDisplayDoggoGalleryShouldChangePhotosAmountLabelText() {
        _ = view?.view
        let preCallText = view!.photosAmountLabel.text!
        view!.displayDoggoGallery(withViewModel: DoggoViewModel(name: "foo", photos: [URL(string: "www.test.com")!]))
        let postCallText = view!.photosAmountLabel.text!
        XCTAssertNotEqual(preCallText, postCallText)
        XCTAssertEqual(postCallText, "1\nPhotos")
    }
    
    func testDisplayDoggoGalleryShouldChangeLoadingLabelText() {
        _ = view?.view
        let preCallText = view!.loadingLabel.text!
        view!.displayDoggoGallery(withViewModel: DoggoViewModel(name: "foo", photos: [URL(string: "www.test.com")!]))
        let postCallText = view!.loadingLabel.text!
        XCTAssertNotEqual(preCallText, postCallText)
        XCTAssertEqual(postCallText, "Loaded 0/1")
    }
    
    func testDisplayDoggoGalleryShouldUpdatePhotosArray() {
        _ = view?.view
        view!.displayDoggoGallery(withViewModel: DoggoViewModel(name: "foo", photos: [URL(string: "www.test.com")!]))
        XCTAssertEqual(view!.photos.count, 1)
        XCTAssertEqual(view!.photos[0].url, URL(string: "www.test.com")!)
        XCTAssertNil(view!.photos[0].image)
    }
    
    
    func testSetImageForCellAtIndexShouldSetGalleryItemImage() {
        _ = view?.view
        let data = UIImagePNGRepresentation(#imageLiteral(resourceName: "dog-paw"))
        let item = GalleryItem(url: URL(string: "www.test.com")!, image: nil)
        view!.photos.append(item)
        view!.setImageForCellAtIndex(0, withData: data!)
        XCTAssertNotEqual(view!.photos[0].image, #imageLiteral(resourceName: "dog-paw"))
    }
    
    func testSetImageForCellAtIndexShouldUpdateLoadingLabelText() {
        _ = view?.view
        let data = UIImagePNGRepresentation(#imageLiteral(resourceName: "dog-paw"))
        let item = GalleryItem(url: URL(string: "www.test.com")!, image: nil)
        view!.photos.append(item)
        let preCallText = view!.loadingLabel.text!
        view!.setImageForCellAtIndex(0, withData: data!)
        let postCallText = view!.loadingLabel!.text!
        XCTAssertNotEqual(preCallText, postCallText)
        XCTAssertEqual(postCallText, "Loaded 1/1")
    }
    
}
