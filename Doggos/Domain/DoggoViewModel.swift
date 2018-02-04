//
//  DoggoViewModel.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

struct DoggoViewModel: ViewModelProtocol {
    typealias Model = Doggo
    let name: String
    let photos: [URL]
    
    static func viewModelFromObject(object: Doggo) -> DoggoViewModel {
        return DoggoViewModel(name: object.name.capitalized, photos: object.photos)
    }
    static func viewModelsFromObjects(objects: [Doggo]) -> [DoggoViewModel] {
        return objects.map({DoggoViewModel.viewModelFromObject(object: $0)})
    }
}
