//
//  Bundle+Ext.swift
//  UnitTestingTests
//
//  Created by Ismail Kilic on 21.10.2021.
//  Copyright © 2021 İsmail KILIÇ. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }

        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }

       return loaded
    }
}
