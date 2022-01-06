//
//  WSResponse.swift
//  UnitTesting


import Foundation
// MARK: - Paramaters
import Foundation
// MARK: - Paramaters
struct WSResponse<T: Codable>: Codable {
    let results: T?

    enum CodingKeys: String, CodingKey {
        case results
    }

}
