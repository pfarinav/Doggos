//
//  ConfigHelper.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation

class ConfigHelper {
    private static var myDict: NSDictionary?
    static func get(valueForKey key: String) -> String? {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict, let value = dict[key] as? String {
            return value
        }
        return nil
    }
}
