//
//  GalleryCollectionViewCell.swift
//  Doggos
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let nibName = "GalleryCollectionViewCell"
    static let identfier = "galleryCell"
    
    //MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var pageNumber: UILabel!
    
    //Properties
    var image: UIImage? = nil {
        didSet{
            if let _image = image {
                spinner.stopAnimating()
                imageView.image = _image
            } else {
                spinner.startAnimating()
                imageView.image = #imageLiteral(resourceName: "dog-paw")
            }
        }
    }
}
