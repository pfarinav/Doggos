//
//  RestSource.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

class RestSource: Datasource {
    //MARK: - Properties
    weak var delegate: DatasourceDelegate?
    var baseUrl = ConfigHelper.get(valueForKey: "RSBaseUrl")
    
    //MARK - Methods
    func getDogsList() {
        let route = "/api/breeds/list/all"
        let dto = DoggoDTO()
        makeRequest(forRoute: route, andDTO: dto)
    }
    
    func getDogGallery(forBreed breed: String) {
        let route = "/api/breed/\(breed)/images"
        let dto = DoggoDTO()
        makeRequest(forRoute: route, andDTO: dto)
    }
    
    private func makeRequest(forRoute route: String, andDTO dto: DTOProtocol) {
        guard let _base = baseUrl, let url = URL(string: "\(_base)\(route)") else {
            let error = DatasourceError(error: "REST API URL not setted or bad formatted: \(baseUrl ?? "")\(route)", code: -1)
            self.delegate?.onFail(error: error)
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [weak self] _data, _response, _error -> Void in
            guard let welf = self else {
                return
            }
            guard let response = _response as? HTTPURLResponse else {
                let error = DatasourceError(error: "Could not get a response", code: -1)
                DispatchQueue.main.async {
                    welf.delegate?.onFail(error: error)
                }
                return
            }
            guard _error == nil else {
                let error = DatasourceError(error: _error!.localizedDescription, code: response.statusCode)
                DispatchQueue.main.async {
                    welf.delegate?.onFail(error: error)
                }
                return
            }
            guard let data = _data else {
                let error = DatasourceError(error: "Could not read data", code: -2)
                DispatchQueue.main.async {
                    welf.delegate?.onFail(error: error)
                }
                return
            }
            
            let _json = try? JSONSerialization.jsonObject(with: data, options: [])
        
            guard let json = _json else {
                let error = DatasourceError(error: "Could not read data", code: -3)
                DispatchQueue.main.async {
                    welf.delegate?.onFail(error: error)
                }
                return
            }
            var _dto = dto
            _dto.data = json
            let result = DatasourceResult(object: _dto, code: response.statusCode)
            DispatchQueue.main.async {
                welf.delegate?.onSuccess(response: result)
            }
            
        }
        task.resume()
    }
}
