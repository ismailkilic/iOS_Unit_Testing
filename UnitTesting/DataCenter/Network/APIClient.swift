//
//  APIClient.swift
//  UnitTesting


import Alamofire
import Foundation

protocol APIClientInterface {

    typealias OnSuccess<T: Codable> = ((WSResponse<T>?) -> Void)?
    typealias OnError = (() -> Void)?

    // MARK: Initial
    func search(term: String, entity: String, offset: Int, limit: Int, completion: @escaping (SearchResponse?) -> Void, onError: ApiProvider.OnError?)
}


class APIClient: APIClientInterface {
    func search(term: String,
                entity: String,
                offset: Int,
                limit: Int,
                completion: @escaping (SearchResponse?) -> Void,
                onError: ApiProvider.OnError?) {

        ApiProvider.shared.performRequest(
            route: .search(term: term,
                           entity: entity,
                           offset: offset,
                           limit: limit),
            onSuccess: completion,
            onError: onError)
    }
}
