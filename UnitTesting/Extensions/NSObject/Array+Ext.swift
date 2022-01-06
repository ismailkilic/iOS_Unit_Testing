//
//  Array+Ext.swift
//  UnitTesting
//
//  Created by İsmail KILIÇ on 30.09.2021.
//  Copyright © 2021 İsmail KILIÇ. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

extension Array {
    func unique<T: Hashable>(by: ((Element) -> (T))) -> [Element] {
        var set = Set<T>() // the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() // keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}
