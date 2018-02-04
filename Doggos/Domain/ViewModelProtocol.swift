//
//  ViewModelProtocol.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Model
    static func viewModelFromObject(object: Model) -> Self
    static func viewModelsFromObjects(objects: [Model]) -> [Self]
}
