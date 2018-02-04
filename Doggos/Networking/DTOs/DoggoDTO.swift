//
//  DoggoDTO.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

struct DoggoDTO: DTOProtocol {
    var data: Any?

    func getDoggos() -> [Doggo]? {
        guard let dict = data as? [String: Any], let list = dict["message"] as? [String: Any] else {
            return nil
        }
        
        return list.keys.map({ type -> Doggo in
            return Doggo(name: type, photos: [])
        })
    }
    
    func getPhotos() -> [URL] {
        guard let dict = data as? [String: Any], let list = dict["message"] as? [String] else {
            return []
        }
        
        return list.flatMap({ strUrl -> URL? in
            let newUrl = URL(string: strUrl)
            if newUrl != nil && newUrl!.isValid() {
                return newUrl!
            } else {
                return nil
            }
        })
    }
}
