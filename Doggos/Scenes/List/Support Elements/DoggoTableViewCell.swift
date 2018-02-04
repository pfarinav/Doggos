//
//  DoggoTableViewCell.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import UIKit

class DoggoTableViewCell: UITableViewCell {
    //MARK: - Static
    static let identifier = "doggoCell"
    static let nibName = "DoggoTableViewCell"
    static let cellHeight: CGFloat = 76
    
    //MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    
    //MARK: - Properties
    var name: String = "" {
        didSet{
            nameLabel.text = name
        }
    }
}
