//
//  Datasource.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

struct DatasourceResult {
    let object: Any?
    let code: Int
}
struct DatasourceError {
    let error: String
    let code: Int
}
protocol DatasourceDelegate: class {
    func onSuccess(response: DatasourceResult)
    func onFail(error: DatasourceError)
}
protocol Datasource: class {
    var delegate: DatasourceDelegate? { get set }
    func getDogsList()
    func getDogGallery(forBreed breed: String)
    
}
