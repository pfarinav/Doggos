//
//  URLValidator.swift
//  Doggos
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import UIKit

extension URL {
    func isValid() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}
