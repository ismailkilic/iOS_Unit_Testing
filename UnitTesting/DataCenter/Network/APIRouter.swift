//
//  APIRouter.swift
//  UnitTesting


import Alamofire
import Foundation

enum APIRouter: URLRequestConvertible {

    case search(term: String, entity: String, offset: Int, limit: Int)
    case test

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        default:
            return .post
        }
    }

    // MARK: - Path
    var path: String {
        switch self {
        case .search: return "/search"
        default: return ""
        }
    }
    // MARK: - baseURL
    private var baseURL: String {
        switch self {
        default:
            return "https://itunes.apple.com"
        }

    }

    // MARK: - ParameterEncoding
    private var encoder: ParameterEncoding {
        if self.method == HTTPMethod.get {
            return URLEncoding()
        } else {
            return JSONEncoding()
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case let .search(term, entity, offset, limit):
            return ["term": term,
                    "entity": entity,
                    "offset": offset,
                    "limit": limit]
        default:
            return nil
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {

        // Request URL
        let url = try baseURL.asURL().appendingPathComponent(path).absoluteString.removingPercentEncoding!.asURL()
        var urlRequest = URLRequest(url: url)

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Headers
        let jsonHeader = "*/*"
        let javascriptHeader = "text/javascript"
        urlRequest.headers.add(.accept(jsonHeader))
       // urlRequest.headers.add(.accept(javascriptHeader))
        urlRequest.headers.add(.contentType(jsonHeader))
       // urlRequest.headers.add(.contentType(javascriptHeader))


        do {
            urlRequest = try encoder.encode(urlRequest, with: parameters)
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }

        return urlRequest
    }

    private func queryString(_ value: String, params: Parameters) -> URL? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in
            URLQueryItem(name: element.key,
                                    value: element.value as? String)
        }

        return components?.url
    }
}
