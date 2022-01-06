//
//  NSObject+Ext.swift
//  UnitTesting
//
//  Created by İsmail KILIÇ on 30.09.2021.
//  Copyright © 2021 İsmail KILIÇ. All rights reserved.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
