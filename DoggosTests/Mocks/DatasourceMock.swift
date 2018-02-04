//
//  DatasourceMock.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
import XCTest
@testable import Doggos

class DatasourceMock: Datasource {
    var didCallDogGallery = false
    func getDogGallery(forBreed breed: String) {
        didCallDogGallery = true
    }
    
    var didCallDogList = false
    func getDogsList() {
        didCallDogList = true
    }
    
    weak var delegate: DatasourceDelegate?
    
    func callOnSuccessWithValidData() {
        let data = ["message": ["foo": "bar"]]
        let doggoDTO = DoggoDTO(data: data)
        let result = DatasourceResult(object: doggoDTO, code: 1)
        delegate?.onSuccess(response: result)
    }
    
    func callOnSuccessWithValidPhotosData() {
        let data = ["message": ["http://www.test.com"]]
        let doggoDTO = DoggoDTO(data: data)
        let result = DatasourceResult(object: doggoDTO, code: 1)
        delegate?.onSuccess(response: result)
    }
    
    func callOnSuccessWithValidButEmptyPhotosData() {
        let data = ["message": []]
        let doggoDTO = DoggoDTO(data: data)
        let result = DatasourceResult(object: doggoDTO, code: 1)
        delegate?.onSuccess(response: result)
    }
    
    func callOnSuccessWithInvalidData() {
        let data = ""
        let doggoDTO = DoggoDTO(data: data)
        let result = DatasourceResult(object: doggoDTO, code: 1)
        delegate?.onSuccess(response: result)
    }
    
    func callOnFail(){
        let error = DatasourceError(error: "error", code: 1)
        delegate?.onFail(error: error)
    }
}
